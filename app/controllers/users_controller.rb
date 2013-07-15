class UsersController < ApplicationController
  include SessionsHelper

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      flash[:success] = "You've successfully created an account."
      sign_in(@user)
      redirect_to user_url(@user.path)
    else
      render 'new'
    end
  end

  def show
    @user = User.find_by_path(params[:path])
    @leagues = League.all
    @teams = Team.all
    @players = Player.all
  end

  def update
  end

  def edit
  end

  def destroy
  end

  private
    def user_params
      params.require(:user).permit(:f_name, :l_name, :email, :password, :password_confirmation)
    end
end
