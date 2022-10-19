class GroupSerializer < ActiveModel::Serializer
  attributes :id, :name, :user_count

  def user_count
    object.group_users.count
  end
end
