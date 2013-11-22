class Product < ActiveRecord::Base
  attr_accessible :description, :name, :price, :size, :stock_quantity, :team_id

  belongs_to :team
  has_many :lineitems
  has_many :orders, :through => :lineitems

  validates :name, :description, :size, :price, :stock_quantity, :presence => true
  validates :description, :length => { :in => 3..100 }
  validates :price, :numericality => true
  validates :stock_quantity, :numericality => { :only_integer => true, :greater_than_or_equal_to => 0 }
  validates :size, :inclusion => { :in => %w(Small Medium Large XL), :message => "%{value} is not a valid size" }
end
