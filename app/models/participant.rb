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
  attr_accessible :address, :age, :batch_id, :blessing_id, :donation, :guarantor, :introducer, :missionary, :name, :occupation, :remark, :sex, :tel, :is_finalized
  belongs_to :blessing
  belongs_to :batch
  validates :name, presence: true
  validates :age, presence: true
  validates :sex, presence: true
  validates :blessing_id, presence: true

  def to_s
    name + "(" + sex + ")"
  end
end
