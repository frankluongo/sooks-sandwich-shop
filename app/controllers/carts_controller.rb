class CartsController < ApplicationController
  before_action :authenticate_user!

  def show
    @cart = Cart.find_by(user_id: current_user.id)
    @products = CartLineItem.where(cart_id: @cart.id)

  end

  def add
    @cart = Cart.find_by(user_id: current_user.id) || Cart.new(
      :user_id => current_user.id
    )

    if @cart.id
      @line_item = CartLineItem.new(
        :cart_id => @cart.id,
        :product_id => params[:line_item_product_id],
        :quantity => params[:line_item_quantity]
      )
      respond_to do |format|
        if @line_item.save!
          format.html { redirect_to cart_path }
          format.json { render :show, status: :created, location: @line_item }
        else
          format.html { render :new }
          format.json { render json: @line_item.errors, status: :unprocessable_entity }
        end
      end
    else
      raise "new cart"
    end



  end

  def remove
    current_user.remove_from_cart(params[:product_id])
    redirect_to cart_path
  end

  def removeone
    current_user.remove_one_from_cart(params[:product_id])
    redirect_to cart_path
  end

  private

  def build_line_items(id, qty)
    {
      pid: id,
      product: Product.find(id),
      quantity: qty
    }
  end

  def cart_params
    params.permit(
      :user_id,
      :line_items,
      :cart_subtotal
    )
  end

  def line_items_params
    params.require(:cart_line_item).permit(
      :name,
      :product_type,
      :description,
      :image,
      :user_id,
      :price,
      :slug
    )
  end

end
