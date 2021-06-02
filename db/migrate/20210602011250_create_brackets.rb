class CreateBrackets < ActiveRecord::Migration[6.1]
  def change
    create_table :brackets do |t|
      t.integer :number_of_entries, default: 0
      t.string :status, default: "created"

      t.timestamps
    end
  end
end
