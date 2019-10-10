class Checkout::ShippingController < CheckoutController
  def update
    respond_to do |format|
      if @order.update(
        shipping_params.merge(
          shipping_details_completed: true
        ))
        format.html { redirect_to checkout_shipping_method_path }
      else
        format.html { redirect_to root_url, notice: 'Oh No!' }
      end
    end
  end

  private

  def shipping_params
    params.require(:order).permit(
      :shipping_first_name,
      :shipping_last_name,
      :shipping_address_line_1,
      :shipping_address_line_2,
      :shipping_state,
      :shipping_country,
      :shipping_city,
      :shipping_zip_code,
      :shipping_phone_number,
      :shipping_email_address
    )
  end

end
