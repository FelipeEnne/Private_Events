class SessionsController < ApplicationController
  before_action :already_logged_in, except: [:destroy]

  def new
  end

  def create
    user = User.find_by(username: params[:sessions][:username])
    if user
      log_in(user)
      redirect_to dashboard_path
      flash['alert-success'] = "Welcome back #{user.name}!"
    else
      flash.now['alert-danger'] = 'Wrong Username/password combination!'
      render :new
    end
  end

  def destroy
    user = current_user
    log_out
    redirect_to root_path
    flash['alert-success'] = "You have successfully logged out #{user.name}!"
  end
end
  