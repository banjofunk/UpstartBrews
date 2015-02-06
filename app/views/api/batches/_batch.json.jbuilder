json.id batch.id
json.state_name batch.state_name
json.states Batch::STATES
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
json.total_carbonation "#{((batch.batch_processes.category('carbonation').map {|batch_process| (batch_process.stopped || Time.current) - batch_process.started }.sum)/60/60).round(1)} hrs"
json.total_bottling "#{((batch.batch_processes.category('bottling').map {|batch_process| (batch_process.stopped || Time.current) - batch_process.started }.sum)/60/60).round(1)} hrs"