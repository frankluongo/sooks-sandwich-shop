class Checkout::ReviewController < CheckoutController

  def show
    @shipping_option = ShippingOption.find(@order.shipping_option)
    @products = OrderLineItem.where(order_id: @order.id).map {|p| {
      product: Product.find(p.product),
      quantity: p.quantity
    }}
  end

  def update
    # respond_to do |format|
    #   if @order.update({
    #     order_subtotal: ,
    #     order_shipping: ,
    #     order_tax: ,
    #     order_total: ,
    #     billing_details_completed: true
    #   })
    #     format.html { redirect_to checkout_shipping_method_path }
    #   else
    #     format.html { redirect_to root_url, notice: 'Oh No!' }
    #   end
    # end
  end

  private

  def billing_params
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
