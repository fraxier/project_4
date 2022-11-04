require 'date_format'

class Event < ApplicationRecord
  has_and_belongs_to_many(:artists)
  has_many :tickets
  has_many :users, through: :tickets

  validates :name, presence: true
  validates :show_date, presence: true
  validates :location, presence: true
  validates :description, presence: true

  scope :headliner, -> { where(is_headliner: true) }
  scope :headliner_and_soon, -> { headliner.where('events.show_date < ?', 'date("now", "+2 months")').order(show_date: :desc) }

  def self.headliners
    Event.where(is_headliner: true).order(show_date: :desc)
  end

  def self.upcoming(max)
    Event.order(show_date: :desc).limit(max)
  end

  def format_date
    date = show_date
    "#{DateFormat.change_to(date, 'ONLY_CURRENT_MONTH_ALPHABET')}
    #{DateFormat.change_to(date, 'ONLY_CURRENT_DATE_NUMBER')}"
  end
end
