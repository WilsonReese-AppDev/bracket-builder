# == Schema Information
#
# Table name: brackets
#
#  id                :bigint           not null, primary key
#  number_of_entries :integer          default(0)
#  status            :string           default("created")
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#
require "test_helper"

class BracketTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
