class EventsController < ApplicationController
  before_action :auth, except: [:index, :create, :show]

  def edit
  end

  def index
    @user = current_user    
    @events_same = Event.where(state: current_user.state) 
    @events_other = Event.where.not(state: current_user.state) 
  end

  def create
    event = Event.new(event_params)
    event.user = current_user
    unless event.save
      flash[:errors] = event.errors.full_messages
    end
      return redirect_to :back
  end

  def update
    event = Event.update(params[:id], event_params)
    if event.valid?
      return redirect_to '/events'
    else
      flash[:errors] = event.erorrs.full_messages
      return redirect_to :back
    end
  end

  def show
    @user = current_user
    @event = Event.find(params[:id])
    @users = @event.users
    @discussions = Discussion.where(event: params[:id])    
  end

  def edit
    @event = Event.find(params[:id])    
  end

  def destroy
    Event.find(params[:id]).destroy
    return redirect_to :back
  end

  private
    def event_params
      params.require(:event).permit(:name, :date, :city, :state)
    end

    def auth
      return redirect_to '/events' unless session[:user_id] ==  Event.find(params[:id]).user.id
    end

end
