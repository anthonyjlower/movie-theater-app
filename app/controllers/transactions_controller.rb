class TransactionsController < ApplicationController

	def create

		exp_date = Date.strptime(params[:credit_card_expiration], '%Y-%m')

		if exp_date > Date.today && params[:credit_card_number].length === 16
			
			@transaction = Transaction.new
			@transaction.email = params[:transaction][:email]
			@transaction.name = params[:transaction][:name]
			@transaction.quantity = params[:quantity]
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
		p '---------------'
		p @transaction
		p '---------------'
	end

end