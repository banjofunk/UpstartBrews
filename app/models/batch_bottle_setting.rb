class BatchBottleSetting < ActiveRecord::Base
  belongs_to :batch

  scope :kind, lambda { |short_name| where(:kind => (KINDS.select {|kind| kind[:short_name] == short_name}).first.try(:[], :kind_id)) }
  KINDS = [
            {:kind_id=>0, :short_name=>'fill_bright_head', :desc=>'Bright Tank Head', :unit => 'psi'},
            {:kind_id=>1, :short_name=>'fill_counter_top', :desc=>'Counter Pressure Top', :unit => 'psi'},
            {:kind_id=>2, :short_name=>'fill_counter_bottom', :desc=>'Counter Pressure Bottom', :unit => 'psi'},
            {:kind_id=>3, :short_name=>'fill_air', :desc=>'Compressed Air Pressure', :unit => 'psi'},
            {:kind_id=>4, :short_name=>'fill_upper', :desc=>'CO2 Blow off line (upper range)', :unit => 'psi'},
            {:kind_id=>5, :short_name=>'fill_lower', :desc=>'fill start line (lower range)', :unit => 'psi'}
          ]

  def readable_kind
    KINDS[self.kind]
  end

  def self.create_or_update_from_hash(h)
    batch_bottle_setting = BatchBottleSetting.where(batch_id: h[:batch_id], kind: h[:kind]).first_or_initialize
    batch_bottle_setting.attributes = h
    batch_bottle_setting.save!
    batch_bottle_setting
  end

end
