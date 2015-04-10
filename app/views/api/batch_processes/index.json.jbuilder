json.all_processes do
  @process_types.each do |category, types|
    json.set! category do
      json.array! types.each do |type|
        json.name type.name
        json.currently_on @batch_processes[category].kind(type.name).current.count > 0
        json.order type.sort_order
        json.category ProcessType::CATEGORIES[type.category]
      end
    end
  end
end
json.current_processes do
  @batch_processes.each do |category, processes|
    json.set! category do
      json.array! processes.each do |batch_process|
        json.partial! '/api/batch_processes/batch_process', batch_process: batch_process
      end
    end
  end
end