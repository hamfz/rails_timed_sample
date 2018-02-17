class User < ApplicationRecord
  NO_SPECIAL_CHARS = /\A[^{}\[\]()<>;:!@#$%^&*\\]+\z/

  has_many :subscriptions, dependent: :destroy
  has_many :product_subscriptions, through: :subscriptions, :source => :product

  devise :database_authenticatable, :registerable, :trackable, :validatable

  validates :first_name, presence: true, allow_blank: false, format: { with: NO_SPECIAL_CHARS, message: 'does not allow certain special characters' }
  validates :last_name, presence: true, allow_blank: false, format: { with: NO_SPECIAL_CHARS, message: 'does not allow certain special characters' }
end
