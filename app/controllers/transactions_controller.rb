class TransactionsController < ApplicationController

	def create

		exp_date = Date.strptime(params[:credit_card_expiration], '%Y-%m')

		# Validate Credit Card Info
		if exp_date > Date.today && params[:credit_card_number].length === 16
			# Find the showing being booked
			showing = Showing.find(params[:id])


			@transaction = Transaction.new
			@transaction.email = params[:transaction][:email]
			@transaction.first_name = params[:transaction][:first_name]
			@transaction.last_name = params[:transaction][:last_name]
			@transaction.quantity = params[:quantity]
			@transaction.cost = @transaction.quantity * showing.price
			@transaction.showing_id = params[:id]
			
			if @transaction.save
				# Send Receipt Email
				ConfirmationMailer.with(transaction: @transaction).receipt_email.deliver_later
				render 'show'
			else
				p @transaction.errors.full_messages
				redirect_to showing_path(params[:id])
			end # End .save if

		else
			redirect_to showing_path(params[:id])
		end # End CC validation If
	end # End Create route

	def show
		@transaction = Transaction.find(params[:id])
	end

	def index
		@all_transactions = []

		Transaction.all.each do |transaction|
			showing = transaction.showing
			movie = showing.movie

			resp ={
				transaction: transaction,
				showing: showing,
				movie: movie
			}
			@all_transactions.push(resp)
		end

	end

	def dashboard
		@total_rev = 0
		@daily_sales = [0, 0, 0, 0, 0, 0, 0]
		@hourly_sales = {}
		@movie_sales = []

		Transaction.all.each do |transaction|
			# Add the total from the transaction to total_rev
			@total_rev += transaction.cost
			# Find the showing the transaction belongs to
			showing = transaction.showing
			# Add the total from the transaction to showings day of the week
			@daily_sales[showing.date.wday] += transaction.cost

			# Check to see if the show time has been see already - if so add the transaction cost to the total
			@hourly_sales.has_key?(showing.time) ? @hourly_sales[showing.time] += transaction.cost : 
				# Otherwise set the total equal to the transaction cost
				@hourly_sales[showing.time] = transaction.cost
		end #End Transaction.all.each loop

		# Find each movies total revenue
		Movie.all.each do |movie|
			movie_sales = 0

			# Loop through all of the transactions for each movie
			movie.transactions.each do |transaction|
				movie_sales += transaction.cost
			end
			
			movie = {
				id: movie.id,
				title: movie.title,
				sales: movie_sales
			}
			@movie_sales.push(movie)
		end #End Movie.all.each loop

	end #End Dashboard Route

end