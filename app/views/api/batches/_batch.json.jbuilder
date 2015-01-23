json.id batch.id
json.fermenter batch.fermenter.id
json.flavor do |flavor|
  flavor.name batch.flavor.name
  flavor.abv batch.flavor.name.split(/\s+/).map(&:first).join.upcase
  flavor.color "Flavor::#{batch.flavor.name.gsub(' ','_').upcase}".constantize
end
json.created_at batch.created_at.strftime("%m/%d/%Y")
json.brew_date batch.brew_date.strftime("%m/%d/%Y")
json.days_ago ((Time.now - batch.brew_date)/(60*60*24)).round
json.last_ph batch.batch_readings.order("reading_date DESC").first.ph.to_f.to_s
json.last_brix batch.batch_readings.order("reading_date DESC").first.brix.to_f.to_s
json.batch_reading_days_ago ((Time.now - batch.batch_readings.order("reading_date DESC").first.reading_date)/(60*60*24)).round

json.batch_readings batch.batch_readings.order("reading_date ASC") do |batch_reading|
  json.partial! 'api/batches/batch_batch_reading', batch_reading: batch_reading
end

json.comments batch.comments.order("created_at ASC") do |comment|
  json.partial! 'api/comments/comment.json', comment: comment
end

json.aerating batch.batch_processes.where(:process_type => 'aeration').where(:stopped => nil).where.not(:started => nil).count > 0
json.aerations batch.batch_processes.where(:process_type => 'aeration').order("created_at ASC") do |batch_process|
  json.partial! 'api/batches/process.json', batch_process: batch_process
end

json.circulating batch.batch_processes.where(:process_type => 'circulation').where(:stopped => nil).where.not(:started => nil).count > 0
json.circulations batch.batch_processes.where(:process_type => 'circulation').order("created_at ASC") do |batch_process|
  json.partial! 'api/batches/process.json', batch_process: batch_process
end

json.ventilating batch.batch_processes.where(:process_type => 'ventilation').where(:stopped => nil).where.not(:started => nil).count > 0
json.ventilations batch.batch_processes.where(:process_type => 'ventilation').order("created_at ASC") do |batch_process|
  json.partial! 'api/batches/process.json', batch_process: batch_process
end
