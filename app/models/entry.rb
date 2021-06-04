# == Schema Information
#
# Table name: entries
#
#  id         :bigint           not null, primary key
#  bracket_id :bigint           not null
#  name       :string
#  seed       :integer
#  eliminated :boolean          default(FALSE)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Entry < ApplicationRecord
  belongs_to :bracket

  has_many :matchups, foreign_key: "winner_id"
  has_many :a_slots, class_name: "Matchup", foreign_key: "option_b_id"
  has_many :b_slots, class_name: "Matchup", foreign_key: "option_b_id"

  # scope :head_to_head, -> { joins(:matchup).where(position: {current: true}) }
end
