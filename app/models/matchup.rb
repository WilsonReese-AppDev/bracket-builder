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
class Matchup < ApplicationRecord
  belongs_to :bracket
  belongs_to :winner, class_name: "Entry", optional: true
  belongs_to :option_a, class_name: "Entry", optional: true
  belongs_to :option_b, class_name: "Entry", optional: true

  after_update :send_winner_to_next_matchup

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

  def assign_round_position
    matchups_in_round = bracket.number_of_entries / 2
    round = 1
    round_position = position
    until round_position <= matchups_in_round
      round_position -= matchups_in_round
      matchups_in_round /= 2
      round += 1
    end
    update!(round_position: round_position)
  end

  def next_matchup
    final_round = Math.log2(bracket.number_of_entries).to_i
    next_round = round + 1
    if round != final_round
      if round_position.odd?
        next_round_position = (round_position + 1) / 2
      else
        next_round_position = round_position / 2
      end
      next_matchup = bracket.matchups.find_by(round: next_round, round_position: next_round_position)
    end
  end

  def send_winner_to_next_matchup
    if round != bracket.final_round
      next_matchup.update!(option_a: winner)
    end
  end

  # def previous_winners
  #   first_previous_winner = bracket.matchups.find_by(position: round_position * 2 - 1).winner
  #   second_previous_winner = bracket.matchups.find_by(position: round_position * 2).winner
  #   return [first_previous_winner, second_previous_winner]
  # end

  # def get_previous_winners
  #   first_previous_winner = bracket.matchups.find_by(position: round_position * 2 - 1).winner
  #   second_previous_winner = bracket.matchups.find_by(position: round_position * 2).winner
  #   update!(option_a: first_previous_winner, option_b: second_previous_winner)
  # end
end
