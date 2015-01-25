class CreateProcessTypes < ActiveRecord::Migration
  def change
    create_table :process_types do |t|
      t.string :name
      t.boolean :secure, null: false, default: false
      t.timestamps
    end
  end
end
