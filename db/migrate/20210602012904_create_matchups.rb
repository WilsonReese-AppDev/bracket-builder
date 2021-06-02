class CreateMatchups < ActiveRecord::Migration[6.1]
  def change
    create_table :matchups do |t|
      t.references :winner, foreign_key: { to_table: :entries }
      t.integer :position
      t.references :bracket, null: false, foreign_key: true
      t.references :option_a, foreign_key: { to_table: :entries }
      t.references :option_b, foreign_key: { to_table: :entries }

      t.timestamps
    end
  end
end
