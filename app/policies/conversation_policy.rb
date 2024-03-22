class ConversationPolicy < ApplicationPolicy
  def show?
    user.conversations.ids.include?(record.id)
  end

  def update?
    record.persisted? && record.owner_id == user.id && record.group?
  end

  def destroy?
    record.persisted? && record.owner_id == user.id
  end
end
