json.id flavor.id
json.name flavor.name
json.abv flavor.name.split(/\s+/).map(&:first).join.upcase
json.color do |color|
  color.primary "Flavor::#{flavor.name.gsub(' ','_').upcase}".constantize[:primary]
  color.secondary "Flavor::#{flavor.name.gsub(' ','_').upcase}".constantize[:secondary]
end