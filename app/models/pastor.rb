class Pastor < ActiveRecord::Base
  attr_accessible :chinesename, :name
  validates :name, presence: true
  validates :chinesename, presence: true
end
