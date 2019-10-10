class Checkout::BillingController < CheckoutController

  def show
    @shipping_option = ShippingOption.find(@order.shipping_option)
    @billing_options = BillingOption.all
    @order.update({
      order_total: @order.order_subtotal + @order.order_shipping + @order.order_tax
    })
  end

  def update
    respond_to do |format|
      if @order.update(
        billing_params.merge(billing_details_completed: true)
      )
        format.html { redirect_to checkout_review_path }
      else
        format.html { redirect_to root_url, notice: 'Oh No!' }
      end
    end
  end

  private

  def billing_params
    if params[:order][:shipping_same_as_billing]
      {
        billing_first_name: @order.shipping_first_name,
        billing_last_name: @order.shipping_last_name,
        billing_address_line_1: @order.shipping_address_line_1,
        billing_address_line_2: @order.shipping_address_line_2,
        billing_country: @order.shipping_country,
        billing_city: @order.shipping_city,
        billing_zip_code: @order.shipping_zip_code,
        billing_phone_number: @order.shipping_phone_number,
        billing_email_address: @order.shipping_email_address,
        billing_state: @order.shipping_state,
        shipping_same_as_billing: true,
        billing_option: params[:order][:billing_option],
      }
    else
      params.require(:order).permit(
        :billing_first_name,
        :billing_last_name,
        :billing_address_line_1,
        :billing_address_line_2,
        :billing_country,
        :billing_city,
        :billing_zip_code,
        :billing_phone_number,
        :billing_email_address,
        :billing_state,
        :shipping_same_as_billing,
        :billing_option
      )
    end

  end

end
