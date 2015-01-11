class Flavor < ActiveRecord::Base
  has_many :batches
  has_many :fermenters

  ROSE_BUD="#C46273"
  LEMON_GINGER="#D67940"
  MINT_GREEN="#92956D"
  BERRY_BLACK="#9F7E9A"

end
