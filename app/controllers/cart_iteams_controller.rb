class CartItemsController < ApplicationController

  def create
    @cart = current_cart
    @cart_item = @cart.cart_items.new(cart_item_params)
    @cart.save
    session[:cart_id] = @cart.id
  end

  def update
    @cart = current_cart
    @cart_item = @cart.cart_items.find(params[:id])
    @cart_item.update_attributes(cart_item_params)
    @cart_items = @cart.cart_items
  end

  def destroy
    @cart = current_cart
    @cart_item = @cart.cart_items.find(params[:id])
    @cart_item.destroy
    @cart_items = @cart.cart_items
  end

  private
    def cart_item_params
      params.require(:cart_item).permit(:product_id, :quantity)
    end
end
