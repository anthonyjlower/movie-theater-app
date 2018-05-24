class Transaction < ActiveRecord::Base
	validates :email, presence: true
	validates :first_name, presence: true
	validates :last_name, presence: true
	belongs_to :showing

	def self.active_card(exp_date, cc_number)
		exp_date != '' && 
		Date.strptime(exp_date, '%Y-%m') > Date.today &&
		CreditCardValidations::Luhn.valid?(cc_number) &&
		CreditCardValidations::Detector.new(cc_number).valid?
	end

end