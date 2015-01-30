class CreateBatchProcesses < ActiveRecord::Migration
  def change
    create_table :batch_processes do |t|
      t.integer :batch_id
      t.integer :process_type_id
      t.datetime :started
      t.datetime :stopped
      t.timestamps
    end
  end
end
