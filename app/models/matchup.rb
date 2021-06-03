# == Schema Information
#
# Table name: matchups
#
#  id          :bigint           not null, primary key
#  winner_id   :bigint
#  position    :integer
#  bracket_id  :bigint           not null
#  option_a_id :bigint
#  option_b_id :bigint
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
class Matchup < ApplicationRecord
  belongs_to :bracket
  belongs_to :winner, class_name: "Entry"
  belongs_to :option_a, class_name: "Entry"
  belongs_to :option_b, class_name: "Entry"

  scope :untouched, -> { where(option_a: nil, option_b: nil) }
  scope :unplayed, -> { where(winner: nil) }
end
