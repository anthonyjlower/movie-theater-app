class ShowingsController < ApplicationController 

	def show
		@showing = Showing.find(params[:id])
		@movie = Movie.find_by(id: @showing.movie_id)


		p '---------'
		p @showing
		p @movie
	end


end