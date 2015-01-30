class Inventory < ActiveRecord::Base
  belongs_to :batch
  belongs_to :package_type

  scope :by_package_type, lambda { joins(:package_type).order('package_types.sort_order') }
  scope :kind, lambda { |type| joins(:package_type).where("package_types.name = ?", type) }
  scope :estimated, lambda { where(:state => Inventory::ESTIMATED)}


  STATES = ['estimated', 'active']
  STATES.to_enum.with_index(0).each { |v, idx| self.const_set(v.to_s.upcase, idx) }

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
