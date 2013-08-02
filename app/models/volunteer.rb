class Volunteer < ActiveRecord::Base
  attr_accessible :chinesename, :name
  validates :name, presence: true
end
