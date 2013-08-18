class EventsController < ApplicationController
	include SessionsHelper

	before_action :set_event, only: [:show, :edit, :update, :destroy]
	before_action :set_robots, only: [:new, :edit]

  def new
  	if signed_in?
  		@event = Event.new
		else
			flash[:notice] = "You must be an administrator to access this page."
			redirect_to root_url
		end

		@title = "New Event"
  end

  def create
  	@event = Event.new(event_params)

		if @event.save
			flash[:success] = "New event successfully added."
			redirect_to user_url(current_user.path)
		else
			render 'new'
		end
  end

  def edit
  	@title = "Edit Event"
  end

  def show
  	@title = "#{@event.name_and_date_and_time} | BCAHL"
  	@meta_description = "#{@event.name_and_date_and_time} - Beaver County Adult Hockey League."
  end

  def update
  	if @event.update(event_params)
			flash[:success] = "Event successfully updated."
			redirect_to edit_event_url(@event.path)
		else
			render 'edit'
		end
	end

	def destroy
		if @event.destroy
			flash[:success] = "Event successfully deleted."
			redirect_to user_url(current_user.path)
		else
			flash[:notice] = "Hm. That didn't work as planned."
			redirect_to edit_event_url(@event.path)
		end
	end

  private
  	def event_params
  		params.require(:event).permit(:name, :date_and_time, :description, :photo)
  	end

  	def set_event
  		@event = Event.find_by_path(params[:event_path])
  	end

  	def set_robots
  		@robots = "noindex"
  	end
end
