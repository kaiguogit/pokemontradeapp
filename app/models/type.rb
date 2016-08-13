class Type < ActiveRecord::Base
  has_and_belongs_to_many :species

  validates :name, uniqueness: true
end