json.all_processes do
  ProcessType.all.map(&:name).each do |type|
    currently_on = @batch_processes.kind(type).current.count > 0
    json.set!(type, currently_on)
  end
end
json.batch_processes do
  json.array! @batch_processes do |batch_process|
    json.partial! '/api/batch_processes/batch_process', batch_process: batch_process
  end
end