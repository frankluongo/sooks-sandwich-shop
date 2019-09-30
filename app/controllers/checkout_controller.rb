class CheckoutController < ApplicationController
  before_action :authenticate_user!
  before_action :check_cart!

  def new

  end



  def create
    # render :new
    # redirect_to root_url
    raise "hello!"
  end

  # def shipping

  # end

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
