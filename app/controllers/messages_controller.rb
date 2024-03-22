# frozen_string_literal: true

class MessagesController < ApplicationController
  before_action :authenticate_user!

  def create
    find_conversation
    msg_text = message_params[:text].strip
    return if msg_text.blank?

    @message = Message.new(text: msg_text, user_id: current_user.id, conversation_id: @conversation.id)
    authorize @message

    respond_to do |f|
      f.turbo_stream do
        return if @message.save

        flash.now[:alert] = 'Message was not processed'
        render status: :unprocessable_entity
      end
    end
  end

  private

  def message_params
    params.require(:message).permit(:text)
  end

  def find_conversation
    @conversation = Conversation.find_by(id: params[:conversation_id])
    return if @conversation

    flash[:alert] = t 'pundit.conversation_policy.default'
    redirect_to root_path
  end
end
