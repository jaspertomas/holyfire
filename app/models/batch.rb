# == Schema Information
#
# Table name: batches
#
#  id          :integer          not null, primary key
#  no          :integer
#  gender      :string(255)
#  blessing_id :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Batch < ActiveRecord::Base
  attr_accessible :blessing_id, :gender, :no
  belongs_to :blessing
  has_many :participants

  validates :no, presence: true
  validates :gender, presence: true
  validates :blessing_id, presence: true
  
  def to_s
    self.blessing.location+"-"+self.no.to_s
  end
  
  def self.to_csv(options = {})
    CSV.generate(options) do |csv|
      csv << column_names
      all.each do |batch|
        csv << batch.attributes.values_at(*column_names)
      end
    end
  end
end
