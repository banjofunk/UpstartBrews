class Flavor < ActiveRecord::Base
  has_many :batches
  has_many :fermenters

  ROSE_BUD={:primary=>"#C46273", :secondary=>"#751425"}
  LEMON_GINGER={:primary=>"#D67940", :secondary=>"#913D09"}
  MINT_GREEN={:primary=>"#92956D", :secondary=>"#535629"}
  BERRY_BLACK={:primary=>"#9F7E9A", :secondary=>"#713E69"}

end
