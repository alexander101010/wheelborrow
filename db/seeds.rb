# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'faker'
require "open-uri"

puts "Emptying database"

Tool.destroy_all
Review.destroy_all
Booking.destroy_all
User.destroy_all


file = URI.open('https://picsum.photos/200/300')

puts "creating new users"

5.times do
  user = User.new
  user.first_name = Faker::Name.first_name
  user.last_name = Faker::Name.last_name
  user.email = Faker::Internet.email
  user.password = 'valid_password'
  user.password_confirmation = 'valid_password'
  user.address = Faker::Address.full_address
  user.latitude = Faker::Address.latitude
  user.longitude = Faker::Address.longitude
  file = URI.open(Faker::Fillmurray.image)
  user.photo.attach(io: file, filename: "#{user.first_name.downcase}.jpg", content_type: 'image/jpg')
  user.save!

  # 2.times do
  #   tool = Tool.new
  #   tool.name = Faker::Vehicle.make
  #   tool.description = Faker::Vehicle.standard_specs
  #   tool.price = rand(1..100)
  #   tool.category = ["hand tools", "power tools", "gardening tools"].sample
  #   file = URI.open(Faker::Fillmurray.image)
  #   tool.photo.attach(io: file, filename: "#{user.first_name.downcase}.jpg", content_type: 'image/jpg')
  #   tool.user = user
  #   tool.save!

  #   3.times do
  #     review = Review.new
  #     review.content = Faker::Relationship.familial
  #     review.rating = rand(1..5)
  #   end
  # end
end

puts "#{User.count} users created"
puts "#{Tool.count} tools created"
puts "#{Review.count} reviews created"
puts "#{Booking.count} bookings created"


