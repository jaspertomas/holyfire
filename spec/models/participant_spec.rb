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

require 'spec_helper'

describe Participant do
  pending "add some examples to (or delete) #{__FILE__}"
end
