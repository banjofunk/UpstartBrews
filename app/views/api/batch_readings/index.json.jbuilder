json.array! @batch_readings do |batch_reading|
  json.partial! '/api/batch_readings/batch_reading', batch_reading: batch_reading
end