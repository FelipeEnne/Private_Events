# frozen_string_literal: true

require 'rails_helper'

RSpec.feature 'Authentications', type: :feature do
  let!(:user) do
    User.create(name: 'John Doe',
                username: 'johndoe',
                email: 'johndoe@example.com',
                password: 'johndoe',
                password_confirmation: 'johndoe')
  end

  describe 'Log in' do
    before do
      visit login_path
    end

    it 'shows login form' do
      have_link 'Login', href: login_path
      have_link 'SignUp', href: signup_path
      have_link 'Events', href: events_path
      expect(page).to have_content('Login')
    end

    context 'when supplied data is valid' do
      it 'logs in user' do
        fill_in 'Username', with: user.username
        click_button 'Login'
        expect(page).to have_content("Welcome back #{user.name}!")
        expect(current_path).to eq dashboard_path
        have_link 'Dashboard', href: dashboard_path
        have_link 'Create Event', href: new_event_path
        have_link 'All Event', href: events_path
        have_link 'All Invites', href: invites_path
        have_link 'Logout', href: logout_path
        expect(page).to have_text 'Upcoming Events'
        expect(page).to have_text 'Past Events'
      end
    end

    context 'when supplied data is not valid' do
      it 'shows flash error' do
        fill_in 'Username', with: 'Hmmm'
        click_button 'Login'
        expect(page).to have_content('Wrong Username/password combination!')
        expect(current_path).to eq(login_path)
      end
    end
  end

  describe 'Log out', type: :feature do
    before do
      visit login_path
      fill_in 'Username', with: user.username
      click_button 'Login'
    end

    context 'when logged out' do
      before { click_on 'Logout' }
      it 'redirects me back to the home page' do
        expect(current_path).to eq(root_path)
        expect(page).to have_content("You have successfully logged out #{user.name}!")
      end
    end
  end
end
