class ConfirmationMailerService
  def send_receipt transaction
    ConfirmationMailer.with(transaction: transaction).receipt_email.deliver_later
  end
end
