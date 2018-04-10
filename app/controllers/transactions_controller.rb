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
		@transactions = Transaction.all
	end

end