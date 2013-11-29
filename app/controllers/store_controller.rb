class StoreController < ApplicationController
  before_filter :load_teams, :except => [:search, :add_to_cart, :remove_from_cart]
  before_filter :initialize_shopping_cart

  def index
    @products = Product.all
  end

  def show
    @product = Product.find(params[:id])
  end

  def search
  end

  def search_results
    @products = Product.where("team_id = ? AND name LIKE ?", "#{params[:category]}", "%#{params[:keywords]}%")
  end

  def contact_us
    @company_page = Page.find(2)
  end

  def about_us
    @company_page = Page.find(1)
  end

  def add_to_cart
    id = params[:id].to_i
    session[:products] << id unless session[:products].include?(id)
    redirect_to :action => :index
  end

  def remove_from_cart
    id = params[:id].to_i
    session[:products].delete(id)
    redirect_to :action => :index
  end

  def checkout
    @customer = Customer.new
    @provinces = Province.all
  end

protected
  def load_teams #Used with the search bar that is loaded on each page
    @teams = Team.order('name ASC')
  end

  def initialize_shopping_cart
    session[:products] ||= []
    @shopping_cart = []
    session[:products].each {|prod| @shopping_cart << Product.find(prod) }
  end
end
