class SessionsController < ApplicationController
	include SessionsHelper

  def new
  end

  def create
  	@user = User.find_by_email(params[:email])
  	if @user.authenticate(params[:password])
  		sign_in(@user)
      redirect_to root_url
  	else
  		render 'new'
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
end
