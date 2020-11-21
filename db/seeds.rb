# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

names = ['Rahul Dravid', 'Mark ten', 'Dwight Schrute', 'Micky Ricky']
dobs = [Date.new(1990, 12, 23), Date.new(1990, 05, 23), Date.new(1980, 12, 3), Date.new(1980, 10, 23)]
addresses = ["Flat - 342, NYC", "Flat-17, Delhi", "Flat-89, Macdy", "Flat-784, KFC"]
departments = ['Eng', 'Sales', 'Med', 'Product']

Rails.logger.info "--- Seeding started -----"

names.zip(dobs, addresses, departments).each do |name, dob, address, department|
    next if Employee.find_by_name(name).present?
    Employee.create(name: name, dob: dob, address: address, department: department)
end

Rails.logger.info "--- Seeding finished -----"
