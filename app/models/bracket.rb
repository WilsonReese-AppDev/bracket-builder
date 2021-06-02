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

  enum status: { created: "created", in_progress: "in_progress", completed: "completed" }

  # private
    def create_matchups_and_entries
      self.number_of_entries.times do |i|
        Entry.create!(bracket: self, seed: i)
      end
    end

    # def create_reports_for_bench_users
    #   User.on_bench.each do |user|
    #     user.reports.create!(period: self)
    #   end
    # end
end
