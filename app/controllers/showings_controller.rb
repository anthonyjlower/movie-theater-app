class ShowingsController < ApplicationController
  include ApplicationHelper

	def show
		@showing = Showing.find(params[:id])
		@movie = Movie.find_by(id: @showing.movie_id)
		@transaction = Transaction.new
		@tickets_sold = @showing.transactions.pluck(:quantity).sum
	end
end
