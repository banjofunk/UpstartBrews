class CreateFlavors < ActiveRecord::Migration
  def up
    create_table :flavors do |t|
        t.string :name
        t.timestamps
    end
  end

  def down
    drop_table :flavors
  end
end
