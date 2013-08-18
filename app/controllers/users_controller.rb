class UsersController < ApplicationController
  include SessionsHelper

  before_action :set_robots, only: [:new, :edit, :show]

  def new
    @user = User.new

    @title = "Add User"
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
    @active_seasons = Season.active
    @events = Event.all

    @title = "Admin Panel"
  end

  def update
  end

  def edit
    @title = "Edit User"
  end

  def destroy
  end

  private
    def user_params
      params.require(:user).permit(:f_name, :l_name, :email, :password, :password_confirmation)
    end

    def set_robots
      @robots = "noindex"
    end
end
