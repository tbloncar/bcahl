class UsersController < ApplicationController
  include SessionsHelper

  before_action :set_robots, only: [:new, :show]
  before_action :authorize_super_admin, only: [:new, :create, :update, :destroy]
  before_action :authorize_admin, only: [:show]

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

  def destroy
  end

  private
    def user_params
      params.require(:user).permit(:f_name, :l_name, :email, :password, :password_confirmation)
    end

    def set_robots
      @robots = "noindex"
    end

    def authorize_super_admin
      redirect_to root_url if current_user.try(:email) != ENV['SUPER_ADMIN_EMAIL'] && Rails.env.production?
    end

    def authorize_admin
      redirect_to root_url unless current_user.path == params[:path]
    end
end
