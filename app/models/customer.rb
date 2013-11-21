class Customer < ActiveRecord::Base
  attr_accessible :address, :city, :country, :email, :first_name, :last_name, :postal_code, :province_id

  belongs_to :province
  has_many :orders

  validates :first_name, :last_name, :address, :city, :country, :postal_code, :email, :presence => true
  validates :email, :uniqueness => true
end
