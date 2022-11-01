class Event < ApplicationRecord
  has_and_belongs_to_many(:artists)
  has_many :tickets
  has_many :users, through: :tickets
end