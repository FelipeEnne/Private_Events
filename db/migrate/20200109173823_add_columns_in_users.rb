class AddColumnsInUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :event_attendees, :status, :integer, default: 2
  end
end
