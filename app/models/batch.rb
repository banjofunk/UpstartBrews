class Batch < ActiveRecord::Base
  belongs_to :flavor
  belongs_to :fermenter
  has_many :batch_readings
  has_many :batch_processes
  has_many :comments, :as => :commentable

end
