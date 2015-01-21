json.array! @batches do |batch|
  json.partial! '/api/batches/batch', batch: batch
end