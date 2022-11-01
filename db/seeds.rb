# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
require 'faker'
require 'pry'

# users [username]
users = User.create([
                      { username: Faker::FunnyName.name },
                      { username: Faker::FunnyName.two_word_name },
                      { username: Faker::FunnyName.three_word_name },
                      { username: Faker::FunnyName.four_word_name },
                      { username: Faker::FunnyName.name_with_initial }
                    ])

# events [show_date, location, description]
event_arr = []
artist_arr = []
20.times do
  artist_arr << { name: Faker::Music.band }
end
10.times do
  event_arr << { show_date: Faker::Date.forward(days: 100), location: Faker::Address.city,
                 description: Faker::TvShows::BrooklynNineNine.quote }
end

events = Event.create(event_arr)
artists = Artist.create(artist_arr)

# create relations
events.each do |event|
  event.artists << artists.sample(5) # get 5 random artists
  event.save
end
binding.pry
