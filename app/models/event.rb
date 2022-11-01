class Event < ApplicationRecord
  has_and_belongs_to_many(:artists)
  has_many :tickets
  has_many :users, through: :tickets

  validates :name, presence: true
  validates :show_date, presence: true
  validates :location, presence: true
  validates :description, presence: true

  def self.headliners
    Event.where(is_headliner: true).order(show_date: :desc)
  end

  def self.upcoming(max)
    Event.order(show_date: :desc).limit(max)
  end
end
