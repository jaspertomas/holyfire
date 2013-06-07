# == Schema Information
#
# Table name: blessings
#
#  id          :integer          not null, primary key
#  location    :string(255)
#  date        :date
#  contactinfo :text
#  comments    :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Blessing < ActiveRecord::Base

  attr_accessible :comments, :contactinfo, :date, :location
  has_many :batches
  has_many :participants
  validates :location, presence: true
#  validate :validate_date
  validates_date :date#, :on_or_before => lambda { Date.current }

  
  def to_s
    self.location
  end  

  def filenamefriendlylocation
    location.gsub(/ /, '')
  end
end
