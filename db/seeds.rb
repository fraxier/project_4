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
                      { username: Faker::FunnyName.unique.name },
                      { username: Faker::FunnyName.unique.two_word_name },
                      { username: Faker::FunnyName.unique.three_word_name },
                      { username: Faker::FunnyName.unique.four_word_name },
                      { username: Faker::FunnyName.unique.name_with_initial }
                    ])

# events [show_date, location, description]
event_arr = []
artist_arr = []
20.times do
  artist_arr << { name: Faker::Music.unique.band }
end
10.times do
  event_arr << { name: Faker::Music.album, show_date: Faker::Date.forward(days: 100), location: Faker::Address.city,
                 description: Faker::TvShows::BrooklynNineNine.unique.quote }
end

events = Event.create(event_arr)
artists = Artist.create(artist_arr)

# create relations
count = 0
events.each do |event|
  event.artists << artists.sample(5) # get 5 random artists
  event.is_headliner = (count % 4).zero?
  count += 1
  event.save
end
