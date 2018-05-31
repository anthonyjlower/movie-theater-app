class TransactionsController < ApplicationController

	def create
		if Transaction.active_card(params[:credit_card_expiration], params[:credit_card_number])
			
			@transaction = Transaction.new(transaction_params)
			@transaction.cost = @transaction.quantity * @transaction.showing.price

			if @transaction.save
				ConfirmationMailer.with(transaction: @transaction).receipt_email.deliver_later
				render 'show'
			else
				flash[:notice] = "There is an error with your name or email"
				redirect_to showing_path(params[:transaction][:showing_id])
			end

		else
			flash[:notice] = "There is an error with your credit card information"
			redirect_to showing_path(params[:transaction][:showing_id])
		end
	end

	def show
		@transaction = Transaction.find(params[:id])
	end

	def index
		@all_transactions = []

		Transaction.all.find_each do |transaction|
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

		dash_services = DashboardService

		@total_rev = dash_services.total_rev
		@daily_sales = dash_services.daily_sales
		@hourly_sales = dash_services.hourly_sales
		@movie_sales = dash_services.movie_sales

	end


	private

	def transaction_params
		params.require(:transaction).permit(:email, :first_name, :last_name, :showing_id, :quantity)
	end

end