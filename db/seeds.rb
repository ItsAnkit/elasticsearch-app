# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).

departments = []
['Eng', 'Sales', 'Med', 'Product', 'Eng', 'Sales', 'Med', 'Product'].each do |dep_name|
    dep = Department.find_or_create_by(name: dep_name)
    departments << dep.id
end

names = ['Rahul Dravid', 'Raj ten', 'Dwight Schrute', 'Micky Ricky', 'Miker Biker', 'Rahul Tej', 'Dwimick Schrubiker', 'Chris Nolan']
dobs = [Date.new(1990, 12, 23), Date.new(1990, 05, 23), Date.new(1980, 12, 3), Date.new(1980, 10, 23), Date.new(1990, 12, 23), Date.new(1990, 05, 23), Date.new(1980, 12, 3), Date.new(1980, 10, 23)]
addresses = ["Flat - 342, NYC", "Flat-17, Delhi", "Flat-89, Macdy", "Flat-784, KFC", "Town - 342, NYC", "Town-17, DelhiBrady", "Town-89, KFKC", "Town-784, BK"]

Rails.logger.info "--- Seeding started -----"

names.zip(dobs, addresses, departments).each do |name, dob, address, department_id|
    next if Employee.find_by_name(name).present?
    emp = Employee.create(name: name, dob: dob, address: address, department_id: department_id)
end

Rails.logger.info "--- Seeding finished -----"
