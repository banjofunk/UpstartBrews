json.id aeration.id
json.started aeration.started.try(:strftime, "%m/%d at %I:%M %p").try(:downcase)
json.stopped aeration.stopped.try(:strftime, "%m/%d at %I:%M %p").try(:downcase)
json.duration distance_of_time_in_words(aeration.started, (aeration.stopped || Time.now))
