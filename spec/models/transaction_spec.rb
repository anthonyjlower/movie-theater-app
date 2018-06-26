require 'rails_helper'

RSpec.describe Transaction, type: :model do

  describe 'Passes validations' do
    subject { FactoryBot.build(:transaction) }
    it { is_expected.to be_valid }

    it { is_expected.to validate_presence_of :first_name }
    it { is_expected.to validate_presence_of :last_name }
    it { is_expected.to validate_presence_of :email }
    it { is_expected.to validate_presence_of :quantity }
    it { is_expected.to validate_presence_of :cost }
  end

  describe 'Class methods' do
    describe 'active_card' do
      it 'should validate' do
        expect(Transaction.active_card((Date.today + 31.days).to_s, CreditCardValidations::Factory.random)).to be(true)
      end
    end

    it 'Should fail if it is expired' do
      expect(Transaction.active_card(Date.today.to_s, CreditCardValidations::Factory.random)).to be(false)
    end

    it 'Should fail if the card number is invalid' do
      expect(Transaction.active_card(Date.today.to_s, '111111111111111')).to be(false)
    end
  end
end
