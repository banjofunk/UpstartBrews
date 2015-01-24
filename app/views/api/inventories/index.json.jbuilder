json.package_types @types
json.inventories do
  json.array! @inventories do |inventory|
    json.partial! '/api/inventories/inventory', inventory: inventory
  end
end