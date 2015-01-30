json.array! @batch_bottle_settings do |batch_bottle_setting|
  json.partial! '/api/batch_bottle_settings/batch_bottle_setting', batch_bottle_setting: batch_bottle_setting
end