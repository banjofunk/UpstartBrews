class CreatePackageTypes < ActiveRecord::Migration
  def change
    create_table :package_types do |t|
      t.string :name
      t.string :capacity
      t.integer :sort_order
      t.timestamps
    end
  end
end
