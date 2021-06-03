class CreateEntries < ActiveRecord::Migration[6.1]
  def change
    create_table :entries do |t|
      t.references :bracket, null: false, foreign_key: true, index: true
      t.string :name
      t.integer :seed
      t.boolean :eliminated, default: false

      t.timestamps
    end
  end
end
