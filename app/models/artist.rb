class Artist < ApplicationRecord
  has_and_belongs_to_many(:events)

  def num_events
    events.length
  end
end