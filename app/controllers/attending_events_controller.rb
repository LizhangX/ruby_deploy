class AttendingEventsController < ApplicationController

    def create
        attending_event = AttendingEvent.new()
        attending_event.user = current_user
        attending_event.event = Event.find(params[:id])
        attending_event.save
        return redirect_to :back
    end

    def destroy
        # event = Event.find(params[:id]
        AttendingEvent.where(event: params[:id]).where(user: current_user.id).destroy_all
        return redirect_to :back
    end
end
