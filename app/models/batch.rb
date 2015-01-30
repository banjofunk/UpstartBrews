class Batch < ActiveRecord::Base
  belongs_to :flavor
  belongs_to :fermenter
  has_many :batch_readings
  has_many :batch_processes
  has_many :batch_carbonation_settings
  has_many :batch_bottle_settings
  has_many :inventories
  has_many :comments, :as => :commentable

  after_create :create_inventories

  scope :state, lambda { |state| where(:state => "Batch::#{state.upcase}".constantize) }
  STATES = ['brewing', 'bottling', 'packaged', 'dumped', 'deleted']
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
