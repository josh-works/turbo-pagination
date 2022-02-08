Widget.destroy_all
Brand.destroy_all
5.times do |n|
  b = Brand.find_or_create_by(name: Faker::Appliance.brand)
  b.save if b.valid?
end

50.times do |n|
  brand = Brand.all.sample
  Widget.create(name: Faker::Appliance.equipment, brand: brand)
end