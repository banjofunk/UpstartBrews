class CreateBatchProcesses < ActiveRecord::Migration
  def change
    create_table :batch_processes do |t|
      t.integer :batch_id
      t.string :process_type
      t.datetime :started
      t.datetime :stopped
      t.timestamps
    end
  end
end
