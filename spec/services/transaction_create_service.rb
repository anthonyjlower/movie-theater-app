require 'rails_helper'

RSpec.describe TransactionCreateService, type: :service do
  let(:showing) { create(:showing) }
  subject { TransactionCreateService.new(email: 'test@example.com', first_name: 'First', last_name: 'Last', showing_id: showing.id, quantity: 1) }

  describe 'create' do
    it 'creates transactions correctly' do
      expect { subject.create }.to change { Transaction.all.count }.by(1)
    end
  end
end
