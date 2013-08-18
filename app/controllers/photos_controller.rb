class PhotosController < ApplicationController
	include SessionsHelper

	before_action :set_photo, only: [:destroy]
	before_action :authorize, except: [:index]
	before_action :set_robots, only: [:new]

	def new
		@photo = Photo.new

		@title = "New Photo"
	end

	def create
		@photo = Photo.new(photo_params)

		if @photo.save
			redirect_to photos_url
		else
			render 'new'
		end
	end

	def index
		@photos = Photo.all

		@title = "Photos | Beaver County Adult Hockey League"
		@meta_description = "See photos from Beaver County Adult Hockey League games and clinics."
	end

	def destroy
		@photo.destroy ? flash[:success] = "Photo successfully deleted." : flash[:notice] = "Something went awry."
		
		redirect_to user_url(current_user.path)
	end

	private
		def photo_params
			params.require(:photo).permit(:photo, :description)
		end

		def set_photo
			@photo = Photo.find_by_id(params[:photo_id])
		end

		def authorize
			unless signed_in?
				flash[:notice] = "You don't have permission to do this."
				redirect_to root_url
			end
		end

		def set_robots
  		@robots = "noindex"
  	end
end