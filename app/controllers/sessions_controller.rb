class SessionsController < ApplicationController
  include SessionsHelper

  before_action :set_robots, only: [:new]

  def new
    @title = "Sign In"
  end

  def create
    @user = User.find_by_email(params[:email])
    if @user.authenticate(params[:password])
      sign_in(@user)
      redirect_to user_url(@user.path),
        success: "You signed in successfully."
    else
      redirect_to new_session_url,
        notice: "Hm. Something didn't match up!"
    end
  end

  def destroy
    if signed_in?
      sign_out
      redirect_to root_url,
        success: "You have successfully signed in!"
    else
      redirect_to root_url,
        error: "You are not signed in!"
    end
  end

  private
    def set_robots
      @robots = "noindex"
    end
end
