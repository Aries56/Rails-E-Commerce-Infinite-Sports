class StoreController < ApplicationController
  def index
    @products = Product.all
  end

  def show
    @product = Product.find(params[:id])
  end

  def search

  end

  def search_results
    @products = Product.where("name LIKE ?", "%#{params[:keywords]}%")
  end
end
