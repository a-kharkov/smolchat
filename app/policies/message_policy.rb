# frozen_string_literal: true

class MessagePolicy < ApplicationPolicy
  def create?
    user.id == record.user_id && record.conversation.users.ids.include?(record.user_id)
  end
end
