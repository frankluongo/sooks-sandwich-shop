class CartsController < ApplicationController
  before_action :authenticate_user!

  def show
    @cart = Cart.find_by(user_id: current_user.id)
  end

  def add
    if Cart.find_by(user_id: params[:user_id])
      @cart = Cart.find_by(user_id: params[:user_id])

      line_items = @cart.line_items.push(
          {
            product: Product.find(params[:product_id]),
            quantity: params[:quantity]
          })

      respond_to do |format|
        if @cart.update!(:line_items => line_items)
          format.html { redirect_to cart_path }
          format.json { render :show, status: :created, location: @cart }
        else
          format.html { render :new }
          format.json { render json: @cart.errors, status: :unprocessable_entity }
        end
      end
    else

      @cart = Cart.create(
        user_id: params[:user_id],
        line_items: {
          product: Product.find(params[:product_id]),
          quantity: params[:quantity]
        }
      )
      raise @cart.inspect
      # respond_to do |format|
      #   if @cart.save!
      #     format.html { redirect_to cart_path }
      #     format.json { render :show, status: :created, location: @cart }
      #   else
      #     format.html { render :new }
      #     format.json { render json: @cart.errors, status: :unprocessable_entity }
      #   end
      # end
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

  def cart_params
    params.permit(
      :user_id,
      :line_items,
      :cart_subtotal
    )
  end

end
