# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'faker'


5.times do
  user = User.new
  user.first_name = Faker::Name.first_name
  user.last_name = Faker::Name.last_name
  user.email = Faker::Internet.email
  user.password = 'valid_password'
  user.password_confirmation = 'valid_password'
  user.address = Faker::Address.full_address
  user.save!

  2.times do
    tool = Tool.new
    tool.name = Faker::Vehicle.make
    tool.description = Faker::Vehicle.standard_specs
    tool.price = rand(1..100)
    tool.category = ["hand tools", "power tools", "gardening tools"].sample
    tool.user = user
    tool.save!
  end
end


