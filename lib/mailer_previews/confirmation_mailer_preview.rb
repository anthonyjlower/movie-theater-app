class ConfirmationMailerPreview < ActionMailer::Preview
  # http://localhost:3000/rails/mailers/confirmation_mailer/receipt_email
  def receipt_email
    @transaction = Transaction.first
    @showing = @transaction.showing
    @movie = @showing.movie
    ConfirmationMailer.with(transaction: @transaction).receipt_email.deliver_now
  end
end
