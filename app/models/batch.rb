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
  after_create :create_carbonation_settings
  after_create :create_bottle_settings

  scope :state, lambda { |state| where(:state => "Batch::#{state.upcase}".constantize) }
  STATES = ['brewing', 'bottling', 'packaged', 'dumped', 'deleted']
  STATES.to_enum.with_index(0).each { |v, idx| self.const_set(v.to_s.upcase, idx) }

  def state_name
    STATES[self.state]
  end

  def state_name=(state_name)
    self.state = STATES.index state_name
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

  def create_bottle_settings
    old_batch = Batch.order('brew_date DESC').where(:flavor_id => self.flavor_id).select { |batch| batch.batch_bottle_settings.size > 0 }.first
    BatchBottleSetting::KINDS.map { |kind|
      setting = old_batch.batch_bottle_settings.where(:kind => kind[:kind_id]).first if old_batch
      self.batch_bottle_settings.create(
        :batch_id => self.id,
        :kind => kind[:kind_id],
        :quantity => setting.try(:quantity) || 0,
        :unit => setting.try(:unit) || kind[:unit]
      )
    }
    @batch_bottle_settings = self.batch_bottle_settings
  end

  def create_carbonation_settings
    old_batch = Batch.order('brew_date DESC').where(:flavor_id => self.flavor_id).select { |batch| batch.batch_carbonation_settings.size > 0 }.first
    BatchCarbonationSetting::KINDS.map { |kind|
      setting = old_batch.batch_carbonation_settings.where(:kind => kind[:kind_id]).first if old_batch
      self.batch_carbonation_settings.create(
        :batch_id => self.id,
        :kind => kind[:kind_id],
        :quantity => setting.try(:quantity) || 0,
        :unit => setting.try(:unit) || kind[:unit]
      )
    }
    @batch_carbonation_settings = self.batch_carbonation_settings
  end

end
