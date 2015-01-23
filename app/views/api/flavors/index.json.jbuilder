json.array! @flavors do |flavor|
  json.partial! '/api/flavors/flavor', flavor: flavor
end