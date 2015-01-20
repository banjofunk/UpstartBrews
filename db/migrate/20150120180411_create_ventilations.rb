class CreateVentilations < ActiveRecord::Migration
  def change
    create_table :ventilations do |t|
      t.integer :batch_id
      t.datetime :started
      t.datetime :stopped
      t.timestamps
    end
  end
end
