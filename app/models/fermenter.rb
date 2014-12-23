class Fermenter < ActiveRecord::Base
  has_many :batches
  belongs_to :flavor

end
