json.partial! 'batch', batch: @batch

json.batch_readings do
  json.array! @batch.batch_readings do |batch_reading|
    json.partial! '/api/batch_readings/batch_reading', batch_reading: batch_reading
  end
end



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



json.bottle_settings do
  json.array! @batch.batch_bottle_settings do |batch_bottle_setting|
    json.partial! '/api/batch_bottle_settings/batch_bottle_setting', batch_bottle_setting: batch_bottle_setting
  end
end


json.carbonation_settings do
  json.array! @batch.batch_carbonation_settings do |batch_carbonation_setting|
    json.partial! '/api/batch_carbonation_settings/batch_carbonation_setting', batch_carbonation_setting: batch_carbonation_setting
  end
end

json.comments do
  json.array! @batch.comments do |comment|
    json.partial! '/api/comments/comment', comment: comment
  end
end

json.inventories do
  json.array! @batch.inventories do |inventory|
    json.partial! '/api/inventories/inventory', inventory: inventory
  end
end