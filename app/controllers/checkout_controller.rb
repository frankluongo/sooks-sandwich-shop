class CheckoutController < ApplicationController
  before_action :authenticate_user!
  before_action :set_order

  def new
    @cart = Cart.find_by(user_id: current_or_guest_user.id)
    @products = CartLineItem.where(cart_id: @cart.id)
    build_order_line_items

    respond_to do |format|
      if @order.save
        format.html { redirect_to checkout_shipping_path }
      else
        format.html { redirect_to root_url, notice: 'Oh No!' }
      end
    end
  end

  private

  def build_order_line_items
    @products.each do |p|
      if OrderLineItem.find_by(product: p.product_id, order_id: @order.id).nil?
        line_item = OrderLineItem.create({
          product: p.product_id,
          order_id: @order.id,
          quantity: p.quantity
        })
      end
    end
  end

  def set_order
    @order = Order.find_by(id: session[:current_order_id], order_completed: false) || Order.find_by(user_id: current_or_guest_user.id, order_completed: false) || Order.new(user_id: current_or_guest_user.id)
    session[:current_order_id] = @order.id
  end

end
