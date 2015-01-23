json.id ventilation.id
json.started ventilation.started.try(:strftime, "%m/%d at %I:%M %p").try(:downcase)
json.stopped ventilation.stopped.try(:strftime, "%m/%d at %I:%M %p").try(:downcase)
json.duration distance_of_time_in_words(ventilation.started, (ventilation.stopped || Time.now))