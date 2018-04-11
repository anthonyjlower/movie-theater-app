class TransactionsController < ApplicationController

	def create

		exp_date = Date.strptime(params[:credit_card_expiration], '%Y-%m')

		if exp_date > Date.today && params[:credit_card_number].length === 16
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
				ConfirmationMailer.with(transaction: @transaction).receipt_email.deliver_now
				render 'show'
			else
				p @transaction.errors.full_messages
				redirect_to showing_path(params[:id])
			end
		else
			redirect_to showing_path(params[:id])
			
		end
	end

	def show
		@transaction = Transaction.find(params[:id])
	end

	def index
		transactions = Transaction.all
		@all_transactions = []

		transactions.each do |transaction|
			showing = transaction.showing
			movie = showing.movie

			resp ={
				transaction: transaction,
				showing: showing,
				movie: movie
			}
			@all_transactions.push(resp)
		end
		pp @all_transactions
	end

	def dashboard
		@total_rev = 0
		@daily_sales = [0, 0, 0, 0, 0, 0, 0]
		@hourly_sales = {}
		@movie_sales = []

		transactions = Transaction.all
		transactions.each do |transaction|
			# Add the total from the transaction to total_rev
			@total_rev += transaction.cost
			# Find the transactions showing
			showing = transaction.showing
			# Add the total from the transaction to showings day of the week
			@daily_sales[showing.date.wday] += transaction.cost

			@hourly_sales.has_key?(showing.time) ? @hourly_sales[showing.time] += transaction.cost : 
				@hourly_sales[showing.time] = transaction.cost

		end



		Movie.all.each do |movie|
			movie_sales = 0

			movie.transactions.each do |transaction|
				movie_sales += transaction.cost
			end
			
			movie = {
				id: movie.id,
				title: movie.title,
				sales: movie_sales
			}
			@movie_sales.push(movie)

		end


	end

end