class TransactionsController < ApplicationController

	def create
		if Transaction.active_card(params[:credit_card_expiration], params[:credit_card_number])
			@transaction = TransactionCreateService.new(transaction_params).create
			if @transaction
				ConfirmationMailerService.new.send_receipt(@transaction)
				render 'show'
			else
				flash[:notice] = "There is an error with your name or email"
				redirect_to showing_path(params[:id])
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
		@all_transactions = Transaction.all.includes(:showing, showing: [:movie]).map do |transaction|
			resp ={
				transaction: transaction,
				showing: transaction.showing,
				movie: showing.movie
			}
		end
	end

	def dashboard
		dash_services = DashboardService.new
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
