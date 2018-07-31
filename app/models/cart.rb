class Cart < ApplicationRecord
  has_many :cart_items, dependent: :destroy
  has_many :products, through: :cart_items
  belongs_to :user
  belongs_to :receipt

  before_save :set_subtotal

  def subtotal
    cart_items.collect {|cart_item| cart_item.valid? ? (cart_item.unit_price*cart_item.quantity) : 0}.sum
  end

  private
    def set_subtotal
      self[:subtotal] = subtotal
    end
end
