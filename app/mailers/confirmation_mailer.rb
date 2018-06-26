class ConfirmationMailer < ActionMailer::Base
	default from: 'info@example.com'

	def receipt_email
		@transaction = params[:transaction]
		@showing = @transaction.showing
		@movie = @showing.movie

		mail(to: @transaction.email, subject: 'Your Purchase Receipt')
	end
end
