class Fermenter < ActiveRecord::Base
  has_many :batches
  belongs_to :flavor

  STATES = ['empty', 'full', 'clean', 'dirty', 'cooler']
  STATES.to_enum.with_index(0).each { |v, idx| self.const_set(v.to_s.upcase, idx) }

  def state_name
    STATES[self.state]
  end

end
