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
end
