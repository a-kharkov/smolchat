# frozen_string_literal: true

class ConversationsController < ApplicationController
  before_action :authenticate_user!

  layout 'chat', only: %i[index show]

  def index
    set_conversations
  end

  def new
    @conversation = Conversation.new(group: params[:group] == 'true')
    set_users
  end

  def create
    @conversation = Conversation.new(conversation_params)

    if @conversation.save
      turbo_toast type: 'success', msg: 'Conversation created'
      redirect_to @conversation
    else
      set_users
      respond_to do |f|
        f.html { render :new, status: :unprocessable_entity }
        f.turbo_stream { render status: :unprocessable_entity }
      end
    end
  end

  def show
    return unless find_conversation

    authorize @conversation
    set_conversations
    @messages = @conversation.messages.includes(:user)
  end

  def edit
    return unless find_conversation

    authorize @conversation
    set_users
  end

  def update
    return unless find_conversation

    authorize @conversation
    removed_user_ids = @conversation.users.ids - conversation_params[:user_ids].map(&:to_i)

    if @conversation.update(conversation_params)
      @conversation.touch
      notify_removed_users(removed_user_ids) if removed_user_ids.any?
      turbo_toast type: 'success', msg: 'Conversation updated'
      redirect_to @conversation
    else
      set_users
      respond_to do |f|
        f.html { render :new, status: :unprocessable_entity }
        f.turbo_stream { render status: :unprocessable_entity }
      end
    end
  end

  def destroy
    return unless find_conversation

    authorize @conversation
    removed_user_ids = @conversation.users.ids
    removed_conversation_id = @conversation.id

    if @conversation.destroy
      notify_removed_users(removed_user_ids, removed_conversation_id) if removed_user_ids.any?
      turbo_toast type: 'success', msg: 'Conversation deleted'
      redirect_to root_path
    else
      render :show, status: :unprocessable_entity
    end
  end

  private

  def conversation_params
    params.require(:conversation).permit(:owner_id, :name, :group, user_ids: [])
  end

  def set_conversations
    @conversations = current_user.conversations.order(updated_at: :desc).includes(:messages)
  end

  def find_conversation
    @conversation = Conversation.find_by(id: params[:id])
    return true if @conversation

    flash[:alert] = t 'pundit.conversation_policy.default'
    redirect_to root_path
    false
  end

  def set_users
    if @conversation.group?
      @users = User.where.not(id: current_user.id).order(updated_at: :desc)
    else
      private_conv_ids = Conversation.joins(:users)
                                     .where('users_conversations.user_id = ?', current_user.id)
                                     .where(group: false)
                                     .ids
      excluded_user_ids = User.joins(:conversations).distinct
                              .where(conversations: { id: private_conv_ids })
                              .ids
      @users = User.where.not(id: excluded_user_ids)
    end
  end

  def notify_removed_users(user_ids, conversation_id = @conversation.id)
    user_ids.each do |user_id|
      Turbo::StreamsChannel.broadcast_remove_to "users:#{user_id}:conversations",
                                                target: "conversation_#{conversation_id}"
      Turbo::StreamsChannel.broadcast_refresh_to "users:#{user_id}:conversations:#{conversation_id}"
    end
  end
end
