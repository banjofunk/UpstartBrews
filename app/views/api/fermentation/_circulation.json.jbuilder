json.id circulation.id
json.started circulation.started.try(:strftime, "%m/%d at %I:%M %p").try(:downcase)
json.stopped circulation.stopped.try(:strftime, "%m/%d at %I:%M %p").try(:downcase)
json.duration distance_of_time_in_words(circulation.started, (circulation.stopped || Time.now))
