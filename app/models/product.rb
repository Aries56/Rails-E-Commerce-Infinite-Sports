class Product < ActiveRecord::Base
  attr_accessible :description, :name, :price, :size, :stock_quantity, :team_id
end
