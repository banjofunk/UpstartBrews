class CreateAerations < ActiveRecord::Migration
  def change
    create_table :aerations do |t|
      t.integer :batch_id
      t.datetime :started
      t.datetime :stopped
      t.timestamps
    end
  end
end
