json.bottling do
  json.array! @bottling_batches do |batch|
    json.partial! '/api/batches/batch', batch: batch
  end
end
json.fermenting do
  json.array! @batches do |batch|
    json.partial! '/api/batches/batch', batch: batch
  end
end