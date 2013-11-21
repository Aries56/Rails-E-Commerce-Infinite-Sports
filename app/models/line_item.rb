class LineItem < ActiveRecord::Base
  attr_accessible :order_id, :price, :product_id, :quantity

  belongs_to :order
  belongs_to :product

  validates :price, :quantity, :presence => true
  validates :quantity, :numericality => { :only_integer => true }
end
