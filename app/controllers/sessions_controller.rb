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
      redirect_to user_url(@user.path)
  	else
      flash[:notice] = "Hm. Something didn't match up."
  		redirect_to new_session_url
  	end
  end

  def destroy
  	if signed_in?
  		sign_out
  		flash[:notice] = "You have successfully signed out."
  		redirect_to root_url
  	else
  		flash[:error] = "You are not signed in."
  		redirect_to root_url
  	end
  end

  private
    def set_robots
      @robots = "noindex"
    end
end
