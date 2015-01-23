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

json.ventilating batch.ventilations.where(:stopped => nil).where.not(:started => nil).count > 0
json.ventilations batch.ventilations.order("created_at ASC") do |ventilation|
  json.partial! 'api/fermentation/ventilation.json', ventilation: ventilation
end
json.circulating batch.circulations.where(:stopped => nil).where.not(:started => nil).count > 0
json.circulations batch.circulations.order("created_at ASC") do |circulation|
  json.partial! 'api/fermentation/circulation.json', circulation: circulation
end

json.aerating batch.aerations.where(:stopped => nil).where.not(:started => nil).count > 0
json.aerations batch.aerations.order("created_at ASC") do |aeration|
  json.partial! 'api/fermentation/aeration.json', aeration: aeration
end
