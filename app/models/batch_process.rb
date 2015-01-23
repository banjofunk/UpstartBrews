class BatchProcess < ActiveRecord::Base
  belongs_to :batches

  scope :kind, lambda { |type| where(:process_type => type).order('started ASC') }
  scope :current, lambda { where.not(:started => nil).where(:stopped => nil) }

end
