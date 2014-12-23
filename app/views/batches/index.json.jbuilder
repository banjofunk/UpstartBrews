json.array! @batches do |batch|
  json.partial! 'batch', batch: batch
end