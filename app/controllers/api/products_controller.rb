class Api::ProductsController < ApplicationController
  before_action :set_product, only: [:show]
  respond_to :json

  # GET /products
  def index
    @products = Product.all
    render json: @products
  end

  # GET /products/1
  def show
    if @product
      render json: @product
    else
      head :not_found
    end
  end

  private
    def set_product
      begin
        @product = Product.find(params[:id])
      rescue
      end
    end
end
