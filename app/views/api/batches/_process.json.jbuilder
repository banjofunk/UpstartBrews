json.id batch_process.id
json.batch_id batch_process.batch_id
json.type batch_process.process_type
json.started batch_process.started.try(:strftime, "%m/%d at %I:%M %p").try(:downcase)
json.stopped batch_process.stopped.try(:strftime, "%m/%d at %I:%M %p").try(:downcase)
json.duration distance_of_time_in_words(batch_process.started, (batch_process.stopped || Time.current))
