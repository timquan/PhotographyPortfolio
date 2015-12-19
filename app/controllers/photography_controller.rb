class PhotographyController < ApplicationController
	def show
	end

	def albums
		@albums = Album.all
	end

  	def album
  		@album = Album.find_by_id(params[:id])
    	@pictures = Picture.where(album_id: @album.id)
  	end


	def pictures
		@pictures = Picture.all
	end

end
