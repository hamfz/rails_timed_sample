class ProductsController < ApplicationController
  before_action :set_product, only: [:show, :edit, :update, :destroy, :subscribe, :unsubscribe]
  before_action :authenticate_user!, only: [:subscribe, :unsubscribe]
  respond_to :html

  # GET /products
  def index
    @products = Product.all
  end

  # GET /products/1
  def show
  end

  # GET /products/new
  def new
    @product = Product.new
  end

  # GET /products/1/edit
  def edit
  end

  # POST /products
  def create
    @product = Product.new(product_params)

    if @product.save
      redirect_to @product, notice: 'Product was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /products/1
  def update
    if @product.update(product_params)
      redirect_to @product, notice: 'Product was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /products/1
  def destroy
    if @product.destroy
      redirect_to products_url, notice: 'Product was successfully destroyed.'
    end
  end


  # PUT /products/1/subscribe
  def subscribe
    if @product.subscribe(current_user)
      redirect_back fallback_location: root_path, notice: "You have subscribed to #{@product.title}"
    end
  end

  # DELETE /products/1/unsubscribe
  def unsubscribe
    if @product.unsubscribe(current_user)
      redirect_back fallback_location: root_path, notice: "You have unsubscribed from #{@product.title}"
    end
  end

  private
    def set_product
      @product = Product.find(params[:id])
    end

    def product_params
      params.require(:product).permit(:title, :description, :website_url, :picture, :tag_list)
    end
end
