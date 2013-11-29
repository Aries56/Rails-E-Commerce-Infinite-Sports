class Order < ActiveRecord::Base
  attr_accessible :customer_id, :gst_rate, :hst_rate, :pst_rate, :status

  belongs_to :customer
  has_many :line_items
  has_many :products, :through => :line_items

  validates :status, :presence => true
end
