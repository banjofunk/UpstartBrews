json.id batch_carbonation_setting.id
json.batch_id batch_carbonation_setting.batch_id
json.created_at batch_carbonation_setting.created_at
json.kind do |kind|
  kind.id batch_carbonation_setting.kind
  kind.short_name batch_carbonation_setting.readable_kind[:short_name]
  kind.desc batch_carbonation_setting.readable_kind[:desc]
  kind.unit batch_carbonation_setting.readable_kind[:unit]
end
json.quantity batch_carbonation_setting.quantity
json.unit batch_carbonation_setting.unit
