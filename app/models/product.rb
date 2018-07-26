class Product < ApplicationRecord
  belongs_to :category
  belongs_to :manufacture
  has_many :comments
  has_many :rates
  has_many :cart_items, dependent: :destroy
  has_many :carts, through: :cart_items

  validates :name, presence: true
  validates :description, presence: true
  validates :price, presence: true
  validates :quantity, presence: true
  validates :picture, allow_blank: true, format: {with: %r{\.(gif|jpg|png)\Z}i, message: "Must be a URL for GIF, JPG, or PNG image."}
end
