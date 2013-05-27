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

require 'spec_helper'

describe Batch do
  pending "add some examples to (or delete) #{__FILE__}"
end
