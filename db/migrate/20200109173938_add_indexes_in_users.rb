class AddIndexesInUsers < ActiveRecord::Migration[6.0]
  def change
    add_index :event_attendees, [:attended_event_id, :attendee_id], unique: true
  end
end
