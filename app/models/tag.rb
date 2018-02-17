class Tag < ApplicationRecord
  has_many :product_tags, dependent: :destroy
  has_many :products, through: :product_tags

  validates :description, presence: true, uniqueness: true
end
