class Batch < ActiveRecord::Base
  belongs_to :flavor
  belongs_to :fermenter
  has_many :batch_readings
  has_many :batch_processes
  has_many :inventories
  has_many :comments, :as => :commentable

  after_create :create_inventories

  private

  def create_inventories
    PackageType.all.each do |package|
      Inventory.create_or_update_from_hash(:batch_id => self.id, :package_type_id => package.id, :quantity => 0)
    end
  end

end
