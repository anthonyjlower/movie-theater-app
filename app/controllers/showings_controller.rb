class ShowingsController < ApplicationController 

	def show
		@showing = Showing.find(params[:id])
		@movie = Movie.find_by(id: @showing.movie_id)
		@transaction = Transaction.new

		@tickets_sold = 0

		@showing.transactions.each do |transaction|
			@tickets_sold += transaction.quantity
		end
	end


end