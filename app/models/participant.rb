# == Schema Information
#
# Table name: participants
#
#  id           :integer          not null, primary key
#  sex          :string(255)
#  name         :string(255)
#  age          :string(255)
#  occupation   :string(255)
#  introducer   :string(255)
#  guarantor    :string(255)
#  address      :string(255)
#  tel          :string(255)
#  missionary   :string(255)
#  remark       :string(255)
#  donation     :string(255)
#  batch_id     :integer
#  blessing_id  :integer
#  is_finalized :boolean
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class Participant < ActiveRecord::Base
  #allow creation of excel spreadsheet
  acts_as_xlsx
    
  attr_accessible :address, :age, :batch_id, :blessing_id, :donation, :guarantor, :introducer, :missionary, :fname, :mname, :lname, :occupation, :remark, :sex, :tel, :is_finalized, :created_by_id, :updated_by_id, :no
  belongs_to :blessing
  belongs_to :batch
  belongs_to :created_by, :class_name => "User", :foreign_key => 'created_by_id'
  belongs_to :updated_by, :class_name => "User", :foreign_key => 'updated_by_id'
  validates :fname, presence: true
  validates :lname, presence: true
  validates :age, presence: true, :numericality => {:greater_than => 0}
  validates :sex, presence: true
  validates :blessing_id, presence: true

  def to_s
    "#{fname} #{mname} #{lname}"
  end
  
  def self.find_all_by_lowercasing_name(str_array)
      wrapped = str_array.collect { |a| " lower(\"participants\".\"name\") LIKE '%"+ "#{a.downcase}" + "%'" }
      return Participant.where("  #{wrapped.join('  AND ')}")
  end  

  
end
