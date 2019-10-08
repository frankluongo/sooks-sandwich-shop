class CheckoutController < ApplicationController
  before_action :authenticate_user!

  def new
    @order = Order.find_by(user_id: current_or_guest_user.id) || Order.new(user_id: current_or_guest_user.id)
    session[:current_order_id] = @order.id

    respond_to do |format|
      if @order.save
        format.html { redirect_to checkout_shipping_path }
      else
        format.html { redirect_to root_url, notice: 'Oh No!' }
      end
    end
  end

  def create
    order = Order.new
    order.user_id = current_user.id
    order.products = current_user.get_cart_products_with_qty
    order.save!

    respond_to do |format|
      if order.save
        format.html { redirect_to shipping_checkout_path }
      else
        format.html { redirect_to root_url, notice: 'Oh No!' }
      end
    end
  end

end
