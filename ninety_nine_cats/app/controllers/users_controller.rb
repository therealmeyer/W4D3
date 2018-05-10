class UsersController < ApplicationController
  before_action :require_logged_out, only: [:new, :create]
  def new
    @user = User.new

    render :new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      login_user!(@user)
    else
      flash[:errors] = @user.errors.full_messages
      redirect_to new_user_url
    end
  end

  private
  def user_params
    params.require(:user).permit(:username, :password)
  end
end
