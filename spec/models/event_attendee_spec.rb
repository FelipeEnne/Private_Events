# frozen_string_literal: true

require 'rails_helper'

RSpec.describe EventAttendee, type: :model do
  context 'validations' do
    it { should validate_presence_of(:attendee_id) }
  end

  context 'Associations' do
    it { should belong_to(:attendee).class_name('User') }
    it { should belong_to(:attended_event).class_name('Event') }
  end
end
