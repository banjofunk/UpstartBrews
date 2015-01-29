class CreateBatches < ActiveRecord::Migration
  def up
    create_table :batches do |t|
        t.integer :flavor_id
        t.integer :fermenter_id
        t.integer :state, null: false, :default => 0
        t.datetime :brew_date
        t.timestamps
    end
  end

  def down
    drop_table :batches
  end
end
