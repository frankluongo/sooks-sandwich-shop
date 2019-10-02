class CheckoutController < ApplicationController
  before_action :authenticate_user!
  before_action :check_cart!

  def new

  end

  def create
    order = Order.new
    order.user_id = current_user.id
    order.products = current_user.get_cart_products_with_qty
    raise current_user.get_cart_products_with_qty.inspect
    order.save!

    respond_to do |format|
      if order.save
        format.html { redirect_to shipping_checkout_path }
      else
        format.html { redirect_to root_url, notice: 'Oh No!' }
      end
    end
  end

  def shipping

  end

  # def billing
  # end

  # def review
  # end

  # def completed
  # end

  private

  def check_cart!
    if current_user.get_cart_products_with_qty.blank?
      redirect_to root_url, alert: "Please add some items to your cart before processing your transaction!"
    end
  end

end
