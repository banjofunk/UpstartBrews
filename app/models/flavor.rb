class Flavor < ActiveRecord::Base
  has_many :batches
  has_many :fermenters

end
