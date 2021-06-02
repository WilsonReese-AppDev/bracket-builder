class Matchup < ApplicationRecord
  belongs_to :winner, class_name: "Entry"
  belongs_to :bracket
  belongs_to :option_a, class_name: "Entry"
  belongs_to :option_b, class_name: "Entry"
end
