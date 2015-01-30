class ProcessType < ActiveRecord::Base
  has_many :batch_processes

  default_scope lambda { order('sort_order ASC') }

  scope :category, lambda { |category| where(:category => "ProcessType::#{category.upcase}".constantize) }
  CATEGORIES=['fermentation', 'carbonation', 'bottling']
  CATEGORIES.to_enum.with_index(0).each { |v, idx| self.const_set(v.to_s.upcase, idx) }

end
