# == Schema Information
#
# Table name: matchups
#
#  id             :bigint           not null, primary key
#  winner_id      :bigint
#  position       :integer
#  bracket_id     :bigint           not null
#  option_a_id    :bigint
#  option_b_id    :bigint
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  round          :integer          default(1)
#  round_position :integer          default(1)
#
require "test_helper"

class MatchupTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
