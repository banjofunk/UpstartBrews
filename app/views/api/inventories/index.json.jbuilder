json.array! @inventories do |inventory|
  json.partial! '/api/inventories/inventory', inventory: inventory
end
