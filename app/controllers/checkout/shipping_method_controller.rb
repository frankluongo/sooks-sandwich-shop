class Checkout::ShippingMethodController < CheckoutController
  before_action :authenticate_user!

  def show
    @order = Order.find(session[:current_order_id])
  end

  def add_shipping_method
    @order = Order.find(session[:current_order_id])
    respond_to do |format|
      if @order.update(shipping_params)
        format.html { redirect_to checkout_shipping_method_path }
      else
        format.html { redirect_to root_url, notice: 'Oh No!' }
      end
    end
  end

  private

  def shipping_params
    params.require(:order).permit(
      :shipping_option
    )
  end

end
