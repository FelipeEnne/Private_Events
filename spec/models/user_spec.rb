# frozen_string_literal: true

require 'rails_helper'
require 'spec_helper'

RSpec.describe User, type: :model do
  it 'validates name, username and email' do
    user = User.new(name: '', username: '', email: '')
    expect(user.valid?).to be(false)
  end

  describe 'ActiveRecord associations' do
    it { should have_many(:created_event).with_foreign_key(:creator_id).class_name('Event').dependent(:destroy) }
    it { should have_many(:event_attendees).with_foreign_key(:attendee_id) }
    it { should have_many(:attended_events).through(:event_attendees) }
  end
end