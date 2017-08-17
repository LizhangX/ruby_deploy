class DiscussionsController < ApplicationController
    def create
        discussion = Discussion.new(discussion_params)
        discussion.user = current_user
        discussion.event = Event.find(params[:id])
        unless discussion.save
            flash[:errors] = discussion.errors.full_messages
        end
        return redirect_to :back
    end

    private
        def discussion_params
            params.require(:discussion).permit(:comment)
        end
end
