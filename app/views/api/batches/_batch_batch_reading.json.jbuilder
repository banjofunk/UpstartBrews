json.id batch_reading.id
json.reading_date batch_reading.reading_date.to_s.split(' ')[0]
json.ph batch_reading.ph.to_f.to_s
json.brix batch_reading.brix.to_f.to_s
json.temp batch_reading.temp
