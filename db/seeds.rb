# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'faker'
require "open-uri"

puts "Start time = #{Time.now}"
puts "Emptying database"

Review.destroy_all
Booking.destroy_all
Tool.destroy_all
User.destroy_all


TOOLS = %w(hammer saw jackhammer paintbrush drill chainsaw bucket broom ladder)
STATUS = %w(pending accepted denied)
ADDRESS =
[
"Museumplein 10, 1071 DJ Amsterdam, Netherlands",
"Museumstraat 1, 1071 XX Amsterdam, Netherlands",
"Museumplein 6, 1071 DJ Amsterdam, Netherlands",
"IJsbaanpad 9, 1076 CV Amsterdam",
"Wijde Heisteeg 1, 1016 AS Amsterdam",
"Nieuwmarkt 4, 1012 CR Amsterdam"
]

puts "creating new users"

5.times do
  file = URI.open('https://www.google.com/search?q=tree&oq=tree&aqs=chrome..69i57j0l3j69i65j69i60l3.16088j0j4&sourceid=chrome&ie=UTF-8')
  user = User.new
  user.first_name = Faker::Name.first_name
  user.last_name = Faker::Name.last_name
  user.email = Faker::Internet.email
  user.password = 'valid_password'
  user.password_confirmation = 'valid_password'
  user.address = ADDRESS.sample
  # file = URI.open(Faker::Fillmurray.image)
  user.photo.attach(io: file, filename: "#{user.first_name.downcase}.jpg", content_type: 'image/jpg')
  user.save!

  2.times do
    tool = Tool.new
    tool.name = TOOLS.sample
    tool.description = Faker::Vehicle.standard_specs
    tool.price = rand(1..100)
    tool.category = ["hand tools", "power tools", "gardening tools"].sample
    file = URI.open("https://source.unsplash.com/1600x900/?#{tool.name}")
    tool.photo.attach(io: file, filename: "#{user.first_name.downcase}.jpg", content_type: 'image/jpg')
    tool.user = user
    tool.save!

    2.times do
      booking = Booking.new
      booking.start_date = Faker::Date.between(from: '2020-09-23', to: '2020-09-25')
      booking.end_date = Faker::Date.between(from: '2020-09-26', to: '2020-09-29')
      booking.status = STATUS.sample
      booking.user = user
      booking.tool = tool
      booking.save

      2.times do
        review = Review.new
        review.content = Faker::Relationship.familial
        review.rating = rand(1..5)
        review.tool = tool
        review.save
      end
    end
  end
end

puts "#{User.count} users created"
puts "#{Tool.count} tools created"
puts "#{Review.count} reviews created"
puts "#{Booking.count} bookings created"

puts "----------------------------------------"
puts "End time #{Time.now}"


