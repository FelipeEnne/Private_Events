# frozen_string_literal: true

require 'rails_helper'

RSpec.feature 'Create Events', type: :feature do
  let!(:user1) do
    User.create(name: 'John Doe',
                username: 'johndoe',
                email: 'johndoe@example.com',
                password: 'johndoe',
                password_confirmation: 'johndoe')
  end

  let!(:user2) do
    User.create(name: 'Jane Barker',
                username: 'janebarker',
                email: 'janebarker@example.com',
                password: 'janebarker',
                password_confirmation: 'janebarker')
  end

  let!(:user3) do
    User.create(name: 'Alen James',
                username: 'alenjames',
                email: 'alenjames@example.com',
                password: 'alenjames',
                password_confirmation: 'alenjames')
  end

  before :each do
    event = user1.created_event.build(title: 'Event testing', description: 'Event description',
                                      address: 'Event Location', start_date: '2020-01-20',
                                      start_time: '2000-01-01 12:00:00')
    event.save

    invite = event.event_attendees.build(attendee_id: 2)
    invite.save
  end

  scenario 'Event creation', type: :feature do
    visit login_path
    page.fill_in 'Username', with: user1.username
    click_button 'Login'

    click_on 'Create Event'
    page.fill_in 'Title', with: 'Event name'
    page.fill_in 'Description', with: 'Event description'
    page.fill_in 'Location', with: 'Event Location'
    page.fill_in 'Date', with: '2020-01-20'
    page.fill_in 'Time', with: '12:00 PM'
    click_button 'Create an Event'
    expect(current_path).to eq dashboard_path
    expect(page).to have_text 'Your event has been created!'
  end

  scenario 'Invite to event', type: :feature do
    visit login_path
    page.fill_in 'Username', with: user1.username
    click_button 'Login'

    click_link 'Event testing'
    expect(page.current_path).to eq '/events/1'
    expect(page).to have_text 'Event testing'
    expect(page).to have_text 'You have no notification'
    click_link('Send Invitation')
    expect(page.current_path).to eq '/send_invite/1'
    expect(page).to have_text "Event: Event testing\nNo of Invites Sent: 1\nNo of Invites Accepted: 0"

    page.choose('attendee_id_3')
    click_button 'Send Invite'
    expect(page.current_path).to eq '/send_invite/1'
    expect(page).to have_text "Event: Event testing\nNo of Invites Sent: 2\nNo of Invites Accepted: 0"
    expect(page).to have_text "Invitation has been successfully sent to #{user3.name}"
  end

  scenario 'Accept Invite', type: :feature do
    visit login_path
    page.fill_in 'Username', with: user2.username
    click_button 'Login'

    expect(page).to have_text "#{user1.name} sent you an invitation to Event ..."
    expect(page).to have_text 'You have 1 event pending to be accepted!'

    click_on "#{user1.name} sent you an invitation to Event ..."
    expect(current_path).to eq(invite_path(1))
    expect(page).to have_text "#{user1.name} invites you to Event testing"
    expect(page).to have_button('Accept Invite')
    expect(page).to have_button('Decline Invite')

    click_button 'Accept Invite'
    expect(current_path).to eq invites_path
    expect(page).to have_text 'You are going to the event!'
    expect(page).to have_text 'You have no notification'
  end
end
