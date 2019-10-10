class Users::OrdersController < UsersController
  def index
    @orders = Order.where(order_completed: true, user_id: current_or_guest_user.id).map do |order|
      {
        order_subtotal: order.order_subtotal,
        order_shipping: order.order_shipping,
        order_tax: order.order_tax,
        order_total: order.order_total,
        shipping_first_name: order.shipping_first_name,
        shipping_last_name: order.shipping_last_name,
        shipping_address_line_1: order.shipping_address_line_1,
        shipping_address_line_2: order.shipping_address_line_2,
        shipping_country: order.shipping_country,
        shipping_city: order.shipping_city,
        shipping_zip_code: order.shipping_zip_code,
        shipping_phone_number: order.shipping_phone_number,
        shipping_email_address: order.shipping_email_address,
        shipping_option: order.shipping_option,
        shipping_state: order.shipping_state,
        products: OrderLineItem.where(order_id: order.id).map { |product|  { product: Product.find(product.product), quantity: product.quantity } }
      }
    end
  end
end
