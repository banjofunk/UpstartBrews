json.id batch.id
json.flavor batch.flavor.name
json.created_at batch.created_at.to_s.split(' ')[0]
json.batch_readings batch.batch_readings do |batch_reading|
  json.partial! 'batch_batch_reading', batch_reading: batch_reading
end
