class EventAttendee < ApplicationRecord
  belongs_to :attendee, class_name: 'User'
  belongs_to :attended_event, class_name: 'Event'

  default_scope -> { order(updated_at: :desc) }

  validates :attendee_id, presence: true
  validates :attendee_id, uniqueness: { scope: :attended_event_id }

  enum :status, [:attending, :declined, :unset]
end
