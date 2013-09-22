class PhotosController < ApplicationController
	include SessionsHelper

	before_action :set_photo, only: [:destroy]
	before_action :authorize, except: [:index]

	def create
		@photo = Photo.new(photo_params)

		if @photo.save
			flash[:success] = "Photo successfully added."
			redirect_to edit_gallery_url(@photo.gallery)
		else
			render 'new'
		end
	end

	def destroy
		gallery = @photo.gallery
		@photo.destroy ? flash[:success] = "Photo successfully deleted." : flash[:notice] = "Something went awry."
		
		redirect_to edit_gallery_url(gallery)
	end

	private
		def photo_params
			params.require(:photo).permit(:photo, :description, :gallery_id)
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