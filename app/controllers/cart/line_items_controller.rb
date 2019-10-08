class Cart::LineItemsController < ApplicationController
  def new
    line_item_exists? ? update : create
  end

  def create
    @line_item = CartLineItem.new(line_items_params)
    @line_item.cart_id = session[:current_cart_id]
    respond_to do |format|
      if @line_item.save
        format.html { redirect_to cart_path, notice: 'Item Added to Your Cart!' }
        format.json { redirect_to cart_path, status: :created, location: @line_item }
      else
        format.html { redirect_to cart_path }
        format.json { render json: @line_item.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @line_item = line_item_exists?
    current_quantity = @line_item.quantity
    added_quantity = params[:cart_line_item][:quantity].to_i
    respond_to do |format|
      if @line_item.update({
        quantity: (current_quantity + added_quantity)
      })
        format.html { redirect_to cart_path, notice: 'Item Added to Your Cart!' }
        format.json { redirect_to cart_path, status: :ok, location: @line_item }
      else
        format.html { redirect_to cart_path }
        format.json { render json: @line_item.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @line_item = CartLineItem.find_by cart_id: session[:current_cart_id], product_id: params[:line_item_id]
    @line_item.destroy
    redirect_to cart_path
  end

  def update_quantity
    @line_item = CartLineItem.find_by cart_id: session[:current_cart_id], product_id: params[:line_item_id]
    respond_to do |format|
      if @line_item.update({
        quantity: params[:product][:quantity].to_i
      })
        format.html { redirect_to cart_path }
        format.json { redirect_to cart_path, status: :ok, location: @line_item }
      else
        format.html { redirect_to cart_path }
        format.json { render json: @line_item.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def line_items_params
    params.require(:cart_line_item).permit(
      :quantity,
      :product_id,
    )
  end

  def line_item_exists?
    CartLineItem.find_by cart_id: session[:current_cart_id], product_id: params[:cart_line_item][:product_id]
  end
end
