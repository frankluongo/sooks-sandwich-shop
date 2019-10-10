class CartsController < ApplicationController
  # before_action :authenticate_user!

  def show
    @cart = Cart.find_by(user_id: current_or_guest_user.id)
    @products = CartLineItem.where(cart_id: @cart.id).map {|p| {
      product: Product.find(p.product_id),
      quantity: p.quantity
    }}
    @cart.update({
      cart_subtotal: @products.reduce(0) { |sum, product| sum + product[:quantity] * product[:product].price }
    })
  end

end
