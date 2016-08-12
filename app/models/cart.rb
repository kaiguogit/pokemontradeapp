class Cart < ActiveRecord::Base
  has_and_belongs_to_many :listings
  belongs_to :user
end