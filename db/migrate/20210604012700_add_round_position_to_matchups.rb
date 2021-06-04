class AddRoundPositionToMatchups < ActiveRecord::Migration[6.1]
  def change
    add_column :matchups, :round_position, :integer, default: 1
  end
end
