class User < ApplicationRecord
  has_many :created_event, foreign_key: 'creator_id', class_name: 'Event', dependent: :destroy
  has_many :event_attendees, foreign_key: 'attendee_id', dependent: :destroy
  has_many :attended_events, through: :event_attendees

  before_save :downcase_email_username
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i.freeze
  validates :name, presence: true, length: { in: 3..50 }
  validates :username, presence: true, length: { in: 3..50 },
                        uniqueness: { case_sensitive: false }
  validates :email, presence: true, length: { maximum: 255 },
                    uniqueness: { case_sensitive: false },
                    format: { with: VALID_EMAIL_REGEX }
  validates :password, length: { maximum: 255 }

  has_secure_password

  private

  def downcase_email_username
    self.email = email.downcase
    self.username = username.downcase
  end

  def name_with_email
    "#{name} (#{email})"
  end
end
