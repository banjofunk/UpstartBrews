json.id batch.id

json.fermenter do |fermenter|
  json.partial! '/api/fermenters/fermenter', fermenter: batch.fermenter
end

json.flavor do |flavor|
  json.partial! '/api/flavors/flavor', flavor: batch.flavor
end

json.inventory_set batch.inventory_set
json.created_at batch.created_at.in_time_zone.strftime("%m/%d/%Y")
json.brew_date batch.brew_date.in_time_zone.strftime("%m/%d/%Y")
json.days_ago ((Time.current - batch.brew_date.in_time_zone)/(60*60*24)).round
json.last_ph batch.batch_readings.count > 0 ? batch.batch_readings.order("reading_date DESC").first.ph.to_f.to_s : 0
json.last_brix batch.batch_readings.count > 0 ? batch.batch_readings.order("reading_date DESC").first.brix.to_f.to_s : 0
json.batch_reading_days_ago batch.batch_readings.count > 0 ? ((Time.current - batch.batch_readings.order("reading_date DESC").first.reading_date.in_time_zone)/(60*60*24)).round : 'n/a'
