class Batch < ActiveRecord::Base
  belongs_to :flavor
  belongs_to :fermenter
  has_many :batch_readings
  has_many :circulations
  has_many :ventilations
  has_many :aerations
  has_many :comments, :as => :commentable

end
