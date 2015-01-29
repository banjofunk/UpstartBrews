class ProcessType < ActiveRecord::Base
  has_many :batch_processes

  default_scope lambda { order('sort_order ASC') }

end
