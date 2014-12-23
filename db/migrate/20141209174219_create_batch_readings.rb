class CreateBatchReadings < ActiveRecord::Migration
  def up
    create_table :batch_readings do |t|
        t.integer :batch_id
        t.float :ph
        t.float :temp
        t.float :brix
        t.datetime :reading_date
        t.timestamps
    end
  end

  def down
    drop_table :batch_readings
  end
end
