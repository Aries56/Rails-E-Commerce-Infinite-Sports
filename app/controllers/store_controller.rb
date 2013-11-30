class StoreController < ApplicationController
  before_filter :load_teams, :except => [:search, :add_to_cart, :remove_from_cart]
  before_filter :initialize_shopping_cart

  def index
    @products = Product.all
  end

  def show
    @product = Product.find(params[:id])
  end

  def team
    @team = Product.where(:team_id => params[:id])
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

  def create_customer
    @customer = Customer.new
    @provinces = Province.all
  end

  def checkout
    @customer = Customer.new(params[:customer])
    @provinces = Province.all

    if @customer.save
      @order = @customer.orders.build
      @order.status = "Processed"
      @order.gst_rate = @customer.province.gst
      @order.pst_rate = @customer.province.pst
      @order.hst_rate = @customer.province.hst
      @order.save

      session[:products].each do |id|
        @product = Product.find(id)
        @line_item = @order.line_items.build
        @line_item.product = @product
        @line_item.price = @product.price
        @line_item.quantity = 1
        @product.stock_quantity -= 1
        @product.save
        @line_item.save 
      end

      session[:products] = []

      redirect_to :action => :order_status
    else
      render :action => :create_customer
    end
  end

  def order_status
    @order = Order.last
    @line_items = LineItem.where(:order_id => @order.id)
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
