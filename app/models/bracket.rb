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
class Bracket < ApplicationRecord
  has_many :entries, dependent: :destroy
  has_many :matchups, dependent: :destroy

# TODO NEED TO MAKE AN after_create ACTION TO AUTOMATICALLY RUN THE METHODS WHEN A BRACKET IS CREATED (like in periods model of status_reporting)

  # make a validation that the number of entries equals an acceptable bracket (8, for now; add 4 and 16 later; add power of 2 later), if not then the bracket needs to fail to create

  enum status: { created: "created", in_progress: "in_progress", completed: "completed" }
  # enum number_of_entries: { eight: 8 } # gonna leave this in to come back to later on, might not need it/reformat it

  def create_entries
    self.number_of_entries.times do |i|
      Entry.create!(bracket: self, seed: i + 1)
    end
  end

  def create_matchups
    iterations = self.number_of_entries - 1
    iterations.times do |i|
      Matchup.create!(bracket: self, position: i + 1)
    end
  end

  def assign_matchups
    first_round_count = (self.number_of_entries) / 2
    entries = self.entries
    matchups = self.matchups

    first_round_count.times do |i|
      matchup = matchups.find_by(position: i + 1)
      entry_a = entries.find_by(seed: i + 1)
      entry_b = entries.find_by(seed: self.number_of_entries - i)
      matchup.update!(option_a: entry_a, option_b: entry_b)
    end
  end

  def matchup_at(position)
    return self.matchups.find_by(position: position)
  end

  def final_round
    final_round = Math.log2(number_of_entries).to_i
  end
end
