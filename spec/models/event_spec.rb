require_relative '../rails_helper'
require 'pry'

describe Event do
  let(:attributes) do
    {
      name: 'Best time of your life',
      show_date: '2weg-0ge-22wg-w-eg11-wweg-egwegwe-eggw2weg0-feweegq 0gw-egw0gewegwe:0gwg0:00',
      location: 'Mississippi',
      description: 'A description so good'
    }
  end

  describe 'Validity of attributes' do
    it 'should have a name' do
      event = Event.new(attributes)

      expect(event.name.length).to be > 0
      expect(event.name).to eq(attributes[:name])
    end

    it 'should have a description' do
      event = Event.new(attributes)

      expect(event.description.length).to be > 0
      expect(event.description).to eq(attributes[:description])
    end

    it 'should have a location' do
      event = Event.new(attributes)

      expect(event.location.length).to be > 0
      expect(event.location).to eq(attributes[:location])
    end

    it 'should have a show date' do
      require 'date'
      event = Event.new(attributes)

      date = event.show_date.to_s
      parsed_date = Date.parse(date.to_s).to_s
      expect(date.include?(parsed_date)).to be true
    end
  end

  describe 'model methods' do
    it 'should be able to get the headline events' do
      expect(Event.headliners).to match_array(Event.where(is_headliner: true))
    end

    it 'should be able to get the n-upcoming events' do
      expect(Event.upcoming(2)).to match_array(Event.order(show_date: :desc).limit(2))
      expect(Event.upcoming(5)).to match_array(Event.order(show_date: :desc).limit(5))
    end
  end
end
