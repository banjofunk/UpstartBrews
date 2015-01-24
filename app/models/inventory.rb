class Inventory < ActiveRecord::Base
  belongs_to :batch
  belongs_to :package_type

  scope :kind, lambda { |type| joins(:package_type).where("package_types.name = ?", type) }

  def flavor
    self.batch.flavor.name
  end

  def package
    self.package_type.name
  end

  def self.create_or_update_from_hash(h)
    inventory = Inventory.where(batch_id: h[:batch_id], package_type_id: h[:package_type_id]).first_or_initialize
    inventory.attributes = h
    inventory.save!
    inventory
  end

end
