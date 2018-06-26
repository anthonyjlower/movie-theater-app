require "rails_helper"

RSpec.describe ConfirmationMailer, type: :mailer do
  describe 'receipt_email' do
    let(:transaction) { create(:transaction) }
    subject { ConfirmationMailer.with(transaction: transaction).receipt_email.deliver_now }

    it 'has the correct subject' do
      expect(subject.subject).to eq('Your Purchase Receipt')
    end

    it 'has the correct receiver email' do
      expect(subject.to[0]).to eq(transaction.email)
    end

    it 'has the correct sender email' do
      expect(subject.from[0]).to eq('info@example.com')
    end

    it 'has the correct ticket quantity' do
      expect(subject.body.encoded).to match(transaction.quantity.to_s)
    end

    it 'has the correct movie title' do
      expect(CGI.unescapeHTML(subject.body.encoded)).to match(transaction.showing.movie.title)
    end

    it 'has the correct showing data' do
      expect(subject.body.encoded).to match(transaction.showing.date.to_s)
    end

    it 'has the correct showing time' do
      expect(subject.body.encoded).to match(transaction.showing.time.to_s)
    end

    it 'has the correct ticket price' do
      expect(subject.body.encoded).to match(transaction.showing.price.to_s)
    end

    it 'has the correct total cost' do
      expect(subject.body.encoded).to match(transaction.cost.to_s)
    end
  end
end
