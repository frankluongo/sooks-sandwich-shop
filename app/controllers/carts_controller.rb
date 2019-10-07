class CartsController < ApplicationController
  before_action :authenticate_user!

  def show
    @cart = Cart.find_by(user_id: current_user.id)
    @products = @cart.line_items
    @products.each do |product|
      puts product.class
    end
  end

  def add
    @cart = Cart.find_by(user_id: current_user.id) || Cart.new
    @cart.user_id = current_user.id

    if @cart.id
      line_items = @cart.line_items.push(
        build_line_items(
          params[:cart][:line_item_product_id],
          params[:cart][:line_item_quantity]
        )
      )

      respond_to do |format|
        if @cart.update!(
          :line_items => line_items
        )
          format.html { redirect_to cart_path }
          format.json { render :show, status: :created, location: @cart }
        else
          format.html { render :new }
          format.json { render json: @cart.errors, status: :unprocessable_entity }
        end
      end
    else
      @cart.line_items = [
        build_line_items(
          params[:cart][:line_item_product_id],
          params[:cart][:line_item_quantity]
        )
      ]

      respond_to do |format|
        if @cart.save!
          format.html { redirect_to cart_path }
          format.json { render :show, status: :created, location: @cart }
        else
          format.html { render :new }
          format.json { render json: @cart.errors, status: :unprocessable_entity }
        end
      end
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

end
