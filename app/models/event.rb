class Event < ApplicationRecord
  belongs_to :creator, class_name: 'User'
  has_many :event_attendees, foreign_key: 'attended_event_id', dependent: :destroy
  has_many :attendees, through: :event_attendees

  validates :title, presence: true, length: { in: 3..50 }
  validates :description, presence: true, length: { minimum: 10 }
  validates :address, presence: true, length: { minimum: 10 }
  validates :start_time, presence: true
  validates :start_date, presence: true
  validates :creator_id, presence: true

  default_scope -> { order(start_date: :desc, start_time: :desc) }

  scope :past, ->(current_user) { where('creator_id = ? AND start_date <= ?', current_user, Time.now.midnight) }
  scope :upcoming, ->(current_user) { where('creator_id = ? AND start_date > ?', current_user, Time.now.midnight) }
  scope :invited_past, ->(current_user) { EventAttendee.joins(:attended_event).where('attendee_id = ? AND status = ? AND start_date <= ?', current_user, 0, Time.now.midnight) }
  scope :invited_upcoming, ->(current_user) { EventAttendee.joins(:attended_event).where('attendee_id = ? AND status = ? AND start_date > ?', current_user, 0, Time.now.midnight) }

  scope :all_past, -> { where('start_date <= ?', Time.now.midnight) }
  scope :all_upcoming, -> { where('start_date > ?', Time.now.midnight) }

  scope :all_attendees, ->(event) { EventAttendee.joins(:attendee).where('attended_event_id = ? AND status = ?', event, 0) }
end
