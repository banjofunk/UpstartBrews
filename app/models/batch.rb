class Batch < ActiveRecord::Base
  belongs_to :flavor
  belongs_to :fermenter
  has_many :batch_readings
  has_many :batch_processes
  has_many :inventories
  has_many :comments, :as => :commentable

  after_create :create_inventories

  # scope :brewing, lambda { where(:state => BREWING)}
  # scope :fermenting, lambda { where(:state => FERMENTING)}
  # scope :carbonating, lambda { where(:state => CARBONATING)}
  # scope :bottling, lambda { where(:state => BOTTLING)}
  # scope :packaged, lambda { where(:state => PACKAGED)}

  STATES = ['brewing', 'fermenting', 'carbonating', 'bottling', 'packaged']
  STATES.to_enum.with_index(0).each { |v, idx| self.const_set(v.to_s.upcase, idx) }

  def state_name
    STATES[self.state]
  end

  def inventory_set
    self.inventories.estimated.count == 0
  end

  private

  def create_inventories
    PackageType.all.each do |package|
      Inventory.create_or_update_from_hash(:batch_id => self.id, :package_type_id => package.id, :quantity => 0)
    end
  end

end
