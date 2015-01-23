# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

lemon = Flavor.create(:name => 'lemon ginger')
berry = Flavor.create(:name => 'berry black')
mint = Flavor.create(:name => 'mint green')
rose = Flavor.create(:name => 'rose bud')

admin = User.create(:email => 'admin@bcj.com', :first_name => "Brad", :last_name => "Minn", :password => 'testeroo', :password_confirmation => 'testeroo', :roles => [:admin])
brewer = User.create(:email => 'brewer@bcj.com', :first_name => "Stew", :last_name => "Burr", :password => 'testeroo', :password_confirmation => 'testeroo', :roles => [:brewer])
sales = User.create(:email => 'sales@bcj.com', :first_name => "Saul", :last_name => "Zimmern", :password => 'testeroo', :password_confirmation => 'testeroo', :roles => [:sales])

ferm_1 = Fermenter.create(:flavor_id => lemon.id,:capacity => 250, :position => 1)
ferm_2 = Fermenter.create(:flavor_id => berry.id,:capacity => 250, :position => 2)
ferm_3 = Fermenter.create(:flavor_id => mint.id,:capacity => 250, :position => 3)
ferm_4 = Fermenter.create(:flavor_id => rose.id,:capacity => 250, :position => 4)
ferm_5 = Fermenter.create(:flavor_id => lemon.id,:capacity => 250, :position => 5)
ferm_6 = Fermenter.create(:flavor_id => berry.id,:capacity => 250, :position => 6)
ferm_7 = Fermenter.create(:flavor_id => mint.id,:capacity => 250, :position => 7)
ferm_8 = Fermenter.create(:flavor_id => rose.id,:capacity => 250, :position => 8)
ferm_9 = Fermenter.create(:flavor_id => lemon.id,:capacity => 250, :position => 9)
ferm_10 = Fermenter.create(:flavor_id => berry.id,:capacity => 250, :position => 10)
ferm_11 = Fermenter.create(:flavor_id => mint.id,:capacity => 250, :position => 11)
ferm_12 = Fermenter.create(:flavor_id => rose.id,:capacity => 250, :position => 12)

#lemon
Batch.create(:flavor_id => lemon.id, :fermenter_id => ferm_1.id, :state => 0, :brew_date => (Time.now-rand(1..20).days))
Batch.create(:flavor_id => lemon.id, :fermenter_id => ferm_9.id, :state => 0, :brew_date => (Time.now-rand(1..20).days))
Batch.create(:flavor_id => lemon.id, :fermenter_id => ferm_5.id, :state => 0, :brew_date => (Time.now-rand(1..20).days))

#berry
Batch.create(:flavor_id => berry.id, :fermenter_id => ferm_2.id, :state => 0, :brew_date => (Time.now-rand(1..20).days))
Batch.create(:flavor_id => berry.id, :fermenter_id => ferm_10.id, :state => 0, :brew_date => (Time.now-rand(1..20).days))
Batch.create(:flavor_id => berry.id, :fermenter_id => ferm_6.id, :state => 0, :brew_date => (Time.now-rand(1..20).days))

#mint
Batch.create(:flavor_id => mint.id, :fermenter_id => ferm_3.id, :state => 0, :brew_date => (Time.now-rand(1..20).days))
Batch.create(:flavor_id => mint.id, :fermenter_id => ferm_11.id, :state => 0, :brew_date => (Time.now-rand(1..20).days))
Batch.create(:flavor_id => mint.id, :fermenter_id => ferm_7.id, :state => 0, :brew_date => (Time.now-rand(1..20).days))

#rose
Batch.create(:flavor_id => rose.id, :fermenter_id => ferm_4.id, :state => 0, :brew_date => (Time.now-rand(1..20).days))
Batch.create(:flavor_id => rose.id, :fermenter_id => ferm_12.id, :state => 0, :brew_date => (Time.now-rand(1..20).days))
Batch.create(:flavor_id => rose.id, :fermenter_id => ferm_8.id, :state => 0, :brew_date => (Time.now-rand(1..20).days))

Batch.all.each do |batch|
  batch.batch_readings.create(:ph => "3.#{rand(7..9)}".to_f.round(1), :temp => "#{rand(68..77)}".to_f.round(1), :brix => "7.#{rand(0..2)}".to_f.round(1), :reading_date => Time.now-rand(10..12).days)
  batch.batch_readings.create(:ph => "3.#{rand(5..7)}".to_f.round(1), :temp => "#{rand(68..77)}".to_f.round(1), :brix => "6.#{rand(8..9)}".to_f.round(1), :reading_date => Time.now-rand(8..9).days)
  batch.batch_readings.create(:ph => "3.#{rand(3..5)}".to_f.round(1), :temp => "#{rand(68..77)}".to_f.round(1), :brix => "6.#{rand(6..8)}".to_f.round(1), :reading_date => Time.now-rand(6..7).days)
  batch.batch_readings.create(:ph => "3.#{rand(2..3)}".to_f.round(1), :temp => "#{rand(68..77)}".to_f.round(1), :brix => "6.#{rand(3..6)}".to_f.round(1), :reading_date => Time.now-rand(3..5).days)
  batch.batch_readings.create(:ph => "3.#{rand(0..2)}".to_f.round(1), :temp => "#{rand(68..77)}".to_f.round(1), :brix => "6.#{rand(0..2)}".to_f.round(1), :reading_date => Time.now-rand(0..2).days)

  batch.comments.create(:user_id => admin.id, :text => "this tastes funky")
  batch.comments.create(:user_id => brewer.id, :text => "nah, it'll be fine")
  batch.comments.create(:user_id => admin.id, :text => "theres a fuck ton of fruit flies...")
  batch.comments.create(:user_id => sales.id, :text => "whatever. sell it to whole foods.")

  batch.circulations.create(:started => batch.brew_date + 4.days, :stopped => Time.now - 1.day)
  batch.ventilations.create(:started => batch.brew_date + 2.days, :stopped => Time.now - 1.day)
end
first_batch = Batch.order('brew_date ASC').first
first_batch.aerations.create(:started => Time.now - 6.hours, :stopped => Time.now - 2.hours)

last_batch = Batch.order('brew_date ASC').last
last_batch.circulations.create(:started => last_batch.brew_date + 4.days)





