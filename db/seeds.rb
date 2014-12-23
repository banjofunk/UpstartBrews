# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

flavor_1 = Flavor.create(:name => 'lemon ginger')
flavor_2 = Flavor.create(:name => 'berry black')
flavor_3 = Flavor.create(:name => 'mint green')
flavor_4 = Flavor.create(:name => 'rose bud')

ferm_1 = Fermenter.create(:flavor_id => flavor_1.id,:capacity => 250)
ferm_2 = Fermenter.create(:flavor_id => flavor_2.id,:capacity => 250)
ferm_3 = Fermenter.create(:flavor_id => flavor_3.id,:capacity => 250)
ferm_4 = Fermenter.create(:flavor_id => flavor_4.id,:capacity => 250)

Batch.create(:flavor_id => flavor_1.id, :fermenter_id => ferm_1.id, :state => 0, :brew_date => (Time.now-1.days))
Batch.create(:flavor_id => flavor_2.id, :fermenter_id => ferm_2.id, :state => 0, :brew_date => (Time.now-2.days))
Batch.create(:flavor_id => flavor_3.id, :fermenter_id => ferm_3.id, :state => 0, :brew_date => (Time.now-3.days))
Batch.create(:flavor_id => flavor_4.id, :fermenter_id => ferm_4.id, :state => 0, :brew_date => (Time.now-4.days))

Batch.all.each do |batch|
  5.times do |i|
    batch.batch_readings.create(:ph => "#{i}.#{i}".to_f, :temp => "#{i+1}#{i}.#{i}".to_f, :brix => "#{i+1}#{i}.#{i}", :reading_date => Time.now-i.days)
  end
end
