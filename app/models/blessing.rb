class Blessing < ActiveRecord::Base
  attr_accessible :comments, :contactinfo, :date, :location
  has_many :batches
  has_many :participants
  
  def to_s
    self.location
  end  
end
