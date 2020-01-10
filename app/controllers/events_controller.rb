class EventsController < ApplicationController
  before_action :logged_in_user, except: [:index]

  def new
    @event = Event.new
  end

  def index
    @events = Event.all

    event_type = params[:type]
    if event_type == 'past_events'
      @all_events = Event.all_past
      @event_text = 'past'
    elsif !event_type || event_type == 'upcoming_events'
      @all_events = Event.all_upcoming
      @event_text = 'upcoming'
    end
  end

  def show
    @event = Event.find(params[:id])
  end

  def create
    @event = current_user.created_event.build(event_params)
    if @event.save
      redirect_to dashboard_path
      flash['alert-success'] = 'Your event has been created!'
    else
      render :new
    end
  end

  private

  def event_params
    params.require(:event).permit(:title, :description, :address, :start_date, :start_time)
  end
end
