class Inventory < ActiveRecord::Base
  belongs_to :batch
  belongs_to :package_type

  def flavor
    self.batch.flavor.name
  end

  def package
    self.package_type.name
  end

end
