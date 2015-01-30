json.array! @batch_carbonation_settings do |batch_carbonation_setting|
  json.partial! '/api/batch_carbonation_settings/batch_carbonation_setting', batch_carbonation_setting: batch_carbonation_setting
end