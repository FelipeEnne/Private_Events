class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper

  def logged_in_user
    unless logged_in?
      flash['alert-danger'] = 'You must be logged in to access that page!'
      redirect_to login_path
    end
  end

  def already_logged_in
    if logged_in?
      flash['alert-warning'] = 'You are already logged in!'
      redirect_to dashboard_path
    end
  end
end
