class AddIndexToArtistsEvents < ActiveRecord::Migration[7.0]
  def change
    add_index :artists_events, %i[artist_id event_id], unique: true
  end
end
