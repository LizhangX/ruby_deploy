class UsersController < ApplicationController
  skip_before_action :require_login, only: [:create, :index]
  before_action :auth, except: [:create, :index]
  def index
  end

  def create
    user = User.create(user_params)
    if user.valid?
      session[:user_id] = user.id
      return redirect_to '/events'
    else
      flash[:errors] = user.errors.full_messages
      return redirect_to :back
    end
  end

  def update
    user = User.update(params[:id], user_params)
    if user.valid?
      return redirect_to '/events'
    else
      flash[:errors] = user.errors.full_messages
      return redirect_to :back
    end
  end

  def edit
    @user = current_user
  end

  private
    def user_params
      params.require(:user).permit(:first_name, :last_name, :email, :password, :city, :state, :password_confirmation)
    end

    def auth
      return redirect_to '/events' unless session[:user_id].to_s == params[:id]
    end
end
