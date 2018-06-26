require 'rails_helper'

RSpec.describe Movie, type: :model do
  subject { FactoryBot.build(:movie) }

  describe 'Passes Validations' do
    it { is_expected.to be_valid }

    it { is_expected.to validate_presence_of :title}
  end
end
