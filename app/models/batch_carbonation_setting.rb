class BatchCarbonationSetting < ActiveRecord::Base
  belongs_to :batch

  scope :kind, lambda { |short_name| where(:kind => (KINDS.select {|kind| kind[:short_name] == short_name}).first.try(:[], :kind_id)) }
  KINDS = [
            {:kind_id=>0, :short_name=>'batch_gallons', :desc=>'kombucha in bright tank', :unit => 'gallons'},
            {:kind_id=>1, :short_name=>'bright_purge', :desc=>'purged head for', :unit => 'seconds'},
            {:kind_id=>2, :short_name=>'bright_head', :desc=>'head pressure', :unit => 'psi'},
            {:kind_id=>3, :short_name=>'bright_stone', :desc=>'stone pressure', :unit => 'psi'}
          ]

  def readable_kind
    KINDS[self.kind]
  end

  def self.create_or_update_from_hash(h)
    batch_carbonation_setting = BatchCarbonationSetting.where(batch_id: h[:batch_id], kind: h[:kind]).first_or_initialize
    batch_carbonation_setting.attributes = h
    batch_carbonation_setting.save!
    batch_carbonation_setting
  end

end
