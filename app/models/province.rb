class Province < ActiveRecord::Base
  attr_accessible :gst, :hst, :name, :pst

  has_many :customers

  validates :name, :pst, :gst, :hst, :presence => true
  validates :pst, :gst, :hst, :numericality => true
end
