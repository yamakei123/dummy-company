class Group < ApplicationRecord
  has_many :group_users, dependent: :destroy

  belongs_to :company, optional: true
  belongs_to :group, optional: true

  validates :name, length: { minimum: 1, maximum: 100 }

end
