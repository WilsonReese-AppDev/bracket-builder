class AddRoundToMatchups < ActiveRecord::Migration[6.1]
  def change
    add_column :matchups, :round, :integer, default: 1
  end
end
