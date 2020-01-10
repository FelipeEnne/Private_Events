class RenameColumnsInUsers < ActiveRecord::Migration[6.0]
  def change
    rename_column :event_attendees, :user_id, :attendee_id
    rename_column :event_attendees, :event_id, :attended_event_id
  end
end
