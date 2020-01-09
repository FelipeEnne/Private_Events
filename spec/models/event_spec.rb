# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Event, type: :model do
  it 'validates presence of title, description, address, start_time, start_date and creator' do
    event = Event.new(title: '', description: '', creator_id: '', address: '', start_time: '', start_date: '')
    expect(event.valid?).to be(false)
  end

  context 'ActiveRecord associations' do
    it { should belong_to(:creator).class_name('User') }
    it { should have_many(:event_attendees).with_foreign_key('attended_event_id').dependent(:destroy) }
    it { should have_many(:attendees).through(:event_attendees) }
  end
end
