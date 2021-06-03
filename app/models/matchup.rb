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
  belongs_to :winner, class_name: "Entry", optional: true
  belongs_to :option_a, class_name: "Entry", optional: true
  belongs_to :option_b, class_name: "Entry", optional: true

  scope :untouched, -> { where(option_a.empty? && option_b.empty?) }
  scope :unplayed, -> { where(winner.empty?) }

  def round
    matchups_in_round = bracket.number_of_entries / 2
    round = 1
    round_position = position
    until round_position <= matchups_in_round
      round_position -= matchups_in_round
      matchups_in_round /= 2
      round += 1
    end
    return round
  end

  def round_position
    matchups_in_round = bracket.number_of_entries / 2
    round = 1
    round_position = position
    until round_position <= matchups_in_round
      round_position -= matchups_in_round
      matchups_in_round /= 2
      round += 1
    end
    return round_position
  end

  def previous_winners
    first_previous_winner = bracket.matchups.find_by(position: round_position * 2 - 1).winner
    second_previous_winner = bracket.matchups.find_by(position: round_position * 2).winner
    return [first_previous_winner, second_previous_winner]
  end
end
