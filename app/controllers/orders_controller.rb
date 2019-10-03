class OrdersController < ApplicationController
  def new
    @order = Order.new(
      user_id: current_user.id,
      products: current_user.get_cart_products_with_qty
    )
  end

  def create
  end
end
