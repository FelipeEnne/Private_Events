class UsersController < ApplicationController
  before_action :logged_in_user, except: [:new, :create]
  before_action :already_logged_in, only: [:new, :create]

  def index
    @users = User.all
  end

  def show
    @events_all = Event.where('creator_id = ?', current_user)
    event_type = params[:type]
    if event_type == 'past_events'
      @user_events = Event.past(current_user)
      @user_invited_events = Event.invited_past(current_user)
      @event_text = 'past'
    elsif !event_type || event_type == 'upcoming_events'
      @user_events = Event.upcoming(current_user)
      @user_invited_events = Event.invited_upcoming(current_user)
      @event_text = 'upcoming'
    end
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in(@user)
      redirect_to dashboard_path
      flash['alert-success'] = 'Your account has been successfully created!'
    else
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :username, :email, :password, :password_confirmation)
  end
end
