class Company < ApplicationRecord
  has_many :users, dependent: :destroy
  has_many :groups, dependent: :destroy
  has_many :group_users, through: :groups

  validates :name, presence: true
  validates :code, length: { minimum: 1, maximum: 50 }, format: { with: /\A[a-zA-Z0-9-]+\z/ }, uniqueness: true, presence: true, on: :create
end
