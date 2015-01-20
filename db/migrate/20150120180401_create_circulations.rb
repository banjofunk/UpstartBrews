class CreateCirculations < ActiveRecord::Migration
  def change
    create_table :circulations do |t|
      t.integer :batch_id
      t.datetime :started
      t.datetime :stopped
      t.timestamps
    end
  end
end
