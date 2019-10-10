class CheckoutController < ApplicationController
  before_action :authenticate_user!
  before_action :check_products
  before_action :set_order

  def create
    @products.each do |p|
      existing_item = OrderLineItem.find_by(product: p.product_id, order_id: @order.id)
      if existing_item
        existing_item.update({
          quantity: p.quantity
        })
      else
        OrderLineItem.create({
          product: p.product_id,
          order_id: @order.id,
          quantity: p.quantity
        })
      end
    end

    @order.update({
      order_subtotal: @cart.cart_subtotal,
      order_tax: 0
    })

    redirect_to checkout_shipping_path
  end

  private

  def set_order
    @order = Order.find_by(id: session[:current_order_id], order_completed: false) || Order.find_by(user_id: current_or_guest_user.id, order_completed: false) || Order.create(user_id: current_or_guest_user.id)
    session[:current_order_id] = @order.id
  end

  def check_products
    @cart = Cart.find_by(user_id: current_or_guest_user.id)
    @products = CartLineItem.where(cart_id: @cart.id)

    if @products.empty?
      redirect_to cart_path, notice: "Please add some sandwiches to check out!"
    end
  end

end
