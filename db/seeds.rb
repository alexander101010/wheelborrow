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


TOOLS = %w(Hammer Saw Jackhammer Paintbrush Drill Chainsaw Bucket Broom Ladder Screwdriver)
STATUS = %w(pending accepted denied)
ADDRESS =
[
"Museumplein 10 Amsterdam",
"Museumstraat 1 Amsterdam",
"Museumplein 6 Amsterdam",
"IJsbaanpad 9 Amsterdam",
"Wijde Heisteeg 1 Amsterdam",
"Nieuwmarkt 4 Amsterdam",
"Linnaeuskade 16 Amsterdam",
"Eerste Atjehstraat 164 Amsterdam",
"Utrechtsestraat 19 Amsterdam",
"Funenkade 5 Amsterdam",
"Kloveniersburgwal 20 Amsterdam",
"Spijkerkade 10 Amsterdam",
"Nieuwendammerdijk 297 Amsterdam"
]

puts "creating new users..."
i=0

10.times do
  user = User.new
  user.first_name = Faker::Name.first_name
  user.last_name = Faker::Name.last_name
  user.email = Faker::Internet.email
  user.password = 'valid_password'
  user.password_confirmation = 'valid_password'
  user.address = ADDRESS[i]
  i+=1
  file = URI.open("https://source.unsplash.com/900x900/?headshot")
  user.photo.attach(io: file, filename: "#{user.first_name.downcase}.jpg", content_type: 'image/jpg')
  user.save!

  4.times do
    tool = Tool.new
    tool.name = TOOLS.sample
    tool.description = Faker::Lorem.paragraph_by_chars(number: 70, supplemental: false)
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

      3.times do
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


