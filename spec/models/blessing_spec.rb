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

require 'spec_helper'

describe Blessing do
  pending "add some examples to (or delete) #{__FILE__}"
end
