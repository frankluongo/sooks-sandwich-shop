class ProductsController < ApplicationController
  before_action :set_product, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_current_cart

  helper_method :set_current_cart

  def set_current_cart

  end

  def index
    @products = Product.all
  end

  def show
    @product = set_product
    @cart = Cart.find_by(user_id: current_or_guest_user.id) || Cart.create(user_id: current_or_guest_user.id)
    @line_item = CartLineItem.new
    session[:current_cart_id] = @cart.id
  end

  def new
    @types = Product::PRODUCT_TYPES
    @product = Product.new
  end

  def edit
    @types = Product::PRODUCT_TYPES
  end

  def create
    @types = Product::PRODUCT_TYPES
    slug = Product.slugify(product_params["name"])
    @product = Product.new(product_params.merge(:slug => slug))

    respond_to do |format|
      if @product.save
        format.html { redirect_to @product, notice: 'Product was successfully created.' }
        format.json { render :show, status: :created, location: @product }
      else
        format.html { render :new }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @product.update(product_params)
        format.html { redirect_to @product, notice: 'Product was successfully updated.' }
        format.json { render :show, status: :ok, location: @product }
      else
        format.html { render :edit }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @product.destroy
    respond_to do |format|
      format.html { redirect_to products_url, notice: 'Product was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_product
      @product = Product.find_by slug: params[:slug]
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def product_params
      params.require(:product).permit(
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
