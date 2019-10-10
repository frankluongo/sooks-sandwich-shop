class Checkout::ShippingMethodController < CheckoutController

  def show
    @shipping_options = ShippingOption.all
  end

  def update
    @order = Order.find(session[:current_order_id])
    shipping_price = ShippingOption.find params[:order][:shipping_option]
    respond_to do |format|
      if @order.update(
        shipping_params.merge({
          shipping_option_completed: true,
          order_shipping: shipping_price.price
        })
      )
        format.html { redirect_to checkout_billing_path }
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
