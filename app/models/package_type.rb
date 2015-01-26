class PackageType < ActiveRecord::Base
  has_many :inventories

  default_scope { order(:sort_order) }

end
