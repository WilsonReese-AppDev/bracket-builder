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
#  round       :integer          default(1)
#
class Matchup < ApplicationRecord
  belongs_to :bracket
  belongs_to :winner, class_name: "Entry", optional: true
  belongs_to :option_a, class_name: "Entry", optional: true
  belongs_to :option_b, class_name: "Entry", optional: true

  scope :untouched, -> { where(option_a.empty? && option_b.empty?) }
  scope :unplayed, -> { where(winner.empty?) }

  def assign_round_to_matchup
    matchups_in_round = bracket.number_of_entries / 2
    round = 1
    round_position = position
    until round_position <= matchups_in_round
      round_position -= matchups_in_round
      matchups_in_round /= 2
      round += 1
    end
    update!(round: round)
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

  def send_winner_to_next_matchup
    if round_position.odd?
      next_round_position = (round_position + 1) / 2
    else
      next_round_position = round_position / 2
    end
    this_round_max_position = 0
    bracket_positions = bracket.number_of_entries
    round.times do
      bracket_positions /= 2
      this_round_max_position += bracket_positions
    end
    next_matchup_position = this_round_max_position + next_round_position
    next_matchup = bracket.matchups.find_by(position: next_matchup_position)
    if round_position.odd?
      next_matchup.update(option_a: winner)
    else
      next_matchup.update(option_b: winner)
    end
  end

  def previous_winners
    first_previous_winner = bracket.matchups.find_by(position: round_position * 2 - 1).winner
    second_previous_winner = bracket.matchups.find_by(position: round_position * 2).winner
    return [first_previous_winner, second_previous_winner]
  end

  def get_previous_winners
    first_previous_winner = bracket.matchups.find_by(position: round_position * 2 - 1).winner
    second_previous_winner = bracket.matchups.find_by(position: round_position * 2).winner
    update!(option_a: first_previous_winner, option_b: second_previous_winner)
  end
end
