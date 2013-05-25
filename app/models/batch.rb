class Batch < ActiveRecord::Base
  attr_accessible :blessing_id, :gender, :no
  belongs_to :blessing
  has_many :participants

  validates :no, presence: true
  validates :gender, presence: true
  validates :blessing_id, presence: true
  
  def to_s
    self.blessing.location+"-"+self.no+"-"+self.gender
  end
end
