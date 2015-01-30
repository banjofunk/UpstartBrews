json.id batch_bottle_setting.id
json.batch_id batch_bottle_setting.batch_id
json.created_at batch_bottle_setting.created_at
json.kind do |kind|
  kind.id batch_bottle_setting.kind
  kind.short_name batch_bottle_setting.readable_kind[:short_name]
  kind.desc batch_bottle_setting.readable_kind[:desc]
  kind.unit batch_bottle_setting.readable_kind[:unit]
end
json.quantity batch_bottle_setting.quantity
json.unit batch_bottle_setting.unit
