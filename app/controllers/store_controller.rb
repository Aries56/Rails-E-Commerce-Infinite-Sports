class StoreController < ApplicationController
  def index
    @products = Product.all
    @teams = Team.order('name ASC')
  end

  def show
    @product = Product.find(params[:id])
    @teams = Team.order('name ASC')
  end

  def search
  end

  def search_results
    @products = Product.where("team_id = ? AND name LIKE ?", "#{params[:category]}", "%#{params[:keywords]}%")
  end
end
