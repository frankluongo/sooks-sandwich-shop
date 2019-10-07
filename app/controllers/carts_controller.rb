class CartsController < ApplicationController
  before_action :authenticate_user!

  def show
    @cart = Cart.find_by(user_id: current_user.id)
    @products = CartLineItem.where(cart_id: @cart.id).map {|p| {
      product: Product.find(p.product_id),
      quantity: p.quantity
    }}
  end

end
