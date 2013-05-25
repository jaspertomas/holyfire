class Blessing < ActiveRecord::Base
  attr_accessor :datestring
  attr_accessible :comments, :contactinfo, :date, :location, :datestring
  has_many :batches
  has_many :participants
  validates :location, presence: true
  validate :validate_date

  
  def to_s
    self.location
  end  
  
  def datestring
    if self.date==nil || self.date==""
      return @datestring
    end
    self.datestring=DateUtil.todatestring(self.date)
  end
  def datestring=(val)
    @datestring = val
    begin
      @date = DateTime.strptime(@datestring, "%m/%d/%Y")
    rescue ArgumentError
      @date=nil
    end
  end
  
  
  private
  
  def validate_datestring
      if self.datestring.nil?
        return false
      elsif self.datestring.empty? 
        return false
      else
        begin
          self.date=DateTime.strptime(self.datestring, "%m/%d/%Y")
        rescue ArgumentError
          false
        end
      end
  end
  
  def validate_date
    errors.add("Date", "is invalid.") unless validate_datestring
  end  
  
  
end
