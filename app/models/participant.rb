class Participant < ActiveRecord::Base
  attr_accessible :address, :age, :batch_id, :blessing_id, :donation, :guarantor, :introducer, :missionary, :name, :occupation, :remark, :sex, :tel
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
