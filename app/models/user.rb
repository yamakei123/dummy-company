class User < ApplicationRecord
  has_many :group_user, dependent: :destroy
  belongs_to :company, optional: true

  validates :first_name, length: { minimum: 1, maximum: 50 }, presence: true
  validates :last_name, length: { minimum: 1, maximum: 50 }, presence: true
  validates :age, numericality: {only_integer: true, greater_than_or_equal_to: 18}
  validates :email, format: { with: /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i }, presence: true
  validate :max_user_count?, on: :create

  def max_user_count?
    if company.users.count > 9
      errors.add(:base, "Only up to 10 people can be added.")
    end
  end
end
