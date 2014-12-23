class CreateFermenters < ActiveRecord::Migration
  def up
    create_table :fermenters do |t|
        t.integer :flavor_id
        t.integer :capacity
        t.timestamps
    end
  end

  def down
    drop_table :fermenters
  end
end
