json.id inventory.id
json.batch_id inventory.batch_id
json.package_type inventory.package_type.name
json.package_name inventory.package_type.name.gsub('_', ' ').pluralize
json.package_img "/assets/#{inventory.package_type.name}.png"
json.package_capacity inventory.package_type.capacity
json.flavor inventory.batch.flavor.name
json.quantity inventory.quantity
