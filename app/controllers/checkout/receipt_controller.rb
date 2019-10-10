class Checkout::ReceiptController < CheckoutController
  def show
    @order.update({order_completed: true})
    cart = Cart.find_by(user_id: current_or_guest_user.id)
    cart_items = CartLineItem.where(cart_id: cart.id)
    cart_items.each do |item|
      item.destroy
    end
  end
end
