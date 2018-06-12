class Transaction < ActiveRecord::Base
	validates_presence_of :showing_id, :quantity, :cost
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
	validates :email, presence: true, length: { maximum: 255}, format: { with: VALID_EMAIL_REGEX }
	validates :first_name, presence: true, length: { maximum: 50}
	validates :last_name, presence: true, length: { maximum: 50}

	belongs_to :showing

	def self.active_card(exp_date, cc_number)
		exp_date != '' &&
		Date.strptime(exp_date, '%Y-%m') > Date.today &&
		CreditCardValidations::Luhn.valid?(cc_number) &&
		CreditCardValidations::Detector.new(cc_number).valid?
	end
end
