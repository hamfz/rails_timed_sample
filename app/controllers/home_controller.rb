class HomeController < ApplicationController
  respond_to :html

  def index
    unless params[:tag]
      @products = Product.contains_search(home_params[:search])
    else
      @products = Product.contains_search(home_params[:search]).by_tag(home_params[:tag])
    end
    @tags = Tag.all
  end

  def mine
    unless params[:tag]
      @products = Product.by_user(current_user).contains_search(home_params[:search])
    else
      @products = Product.by_user(current_user).contains_search(home_params[:search]).by_tag(home_params[:tag])
    end
    @tags = Tag.all
  end

  protected

  def home_params
    params.permit(:tag, :search)
  end

end
