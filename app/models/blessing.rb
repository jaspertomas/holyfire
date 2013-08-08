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
  #allow creation of excel spreadsheet
  acts_as_xlsx
    

  attr_accessible :comments, :contactinfo, :date, :location, :chineseday, :chinesemonth, :chineseyear
  has_many :batches
  has_many :participants
  validates :location, presence: true
#  validates :validate_date
  validates_date :date#, :on_or_before => lambda { Date.current }

  
  def to_s
    self.location
  end  

  def filenamefriendlylocation
    location.gsub(/ /, '')
  end
  def cchineseyear
    if self.chineseyear==nil
      ""
    else
      cnumbers=Setting.find_by_name("cnumbers").value.split(",")
      ccyear=""
      ccyear+=cnumbers[self.chineseyear/1000]
      ccyear+=cnumbers[self.chineseyear%1000/100]
      ccyear+=cnumbers[self.chineseyear%100/10]
      ccyear+=cnumbers[self.chineseyear%10]
      ccyear
    end
  end
  def cchinesemonth
    if self.chinesemonth==nil
      ""
    else
      cnumbers=Setting.find_by_name("cnumbers").value.split(",")
      ccmonth=""
      if(self.chinesemonth>9)
        ccmonth+=cnumbers[self.chinesemonth%100/10] + cnumbers[10]
      end
      ccmonth+=cnumbers[self.chinesemonth%10]

      ccmonth
    end
  end
  def cchineseday
    if self.chinesemonth==nil
      ""
    else
      cnumbers=Setting.find_by_name("cnumbers").value.split(",")
      ccday=""
      if(self.chineseday>9)
        ccday+=cnumbers[self.chineseday%100/10] + cnumbers[10]
      end
        ccday+=cnumbers[self.chineseday%10]

      ccday
    end
  end

end
