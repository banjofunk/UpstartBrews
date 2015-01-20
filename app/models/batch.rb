class Batch < ActiveRecord::Base
  has_many :batch_readings
  belongs_to :flavor
  belongs_to :fermenter
  has_many :comments, :as => :commentable

end
