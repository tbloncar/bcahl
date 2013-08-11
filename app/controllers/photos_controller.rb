class PhotosController < ApplicationController
	include SessionsHelper

	before_action :set_photo, only: [:destroy]
	before_action :authorize, except: [:index]

	def new
		@photo = Photo.new
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
end