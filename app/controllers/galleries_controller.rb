class GalleriesController < ApplicationController
	include SessionsHelper

	before_action :set_gallery, only: [:show, :edit, :update, :destroy]
	before_action :set_robots, only: [:new, :edit]

	def new
		if signed_in?
			@gallery = Gallery.new
		else
			flash[:notice] = "You must be an administrator to access this page."
			redirect_to root_url
		end

		@title = "New Gallery"
	end

	def create
		@gallery = Gallery.new(gallery_params)

		if @gallery.save
			flash[:success] = "New gallery successfully added."
			redirect_to edit_gallery_url(@gallery)
		else
			render 'new'
		end
	end

	def index
		@galleries = Gallery.all

		@title = "Photo Galleries | BCAHL"
		@meta_description = "See photos from BCAHL games, clinics, pickups, and events."
	end

	def show
		@title = "#{@gallery.name} | BCAHL"
		@meta_description = "Check out photos from the BCAHL's \"#{@gallery.name}\" gallery."
	end

	def edit
		@photo = Photo.new
	end

	def update
		if @gallery.update(gallery_params)
			flash[:success] = "Gallery successfully updated."
			redirect_to gallery_url(@gallery)
		else
			render 'edit'
		end
	end

	def destroy
		if @gallery.destroy
			flash[:success] = "Gallery successfully deleted."
			redirect_to user_url(current_user.path)
		else
			flash[:notice] = "Hm. That didn't work as planned."
			redirect_to edit_gallery_url(@gallery)
		end
	end

	private
		def gallery_params
      params.require(:gallery).permit(:name, :description, :date_start, :date_end)
    end

    def set_gallery
    	@gallery = Gallery.find_by_id(params[:id])
    end

    def set_robots
  		@robots = "noindex"
  	end
end