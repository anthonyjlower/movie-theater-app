require 'rails_helper'

RSpec.describe Showing, type: :model do
  subject { FactoryBot.build(:showing) }

  describe 'Passes validations' do
    it { is_expected.to be_valid }

    it { is_expected.to validate_presence_of :date}
    it { is_expected.to validate_presence_of :time}
    it { is_expected.to validate_presence_of :capacity}
    it { is_expected.to validate_presence_of :price}
  end
end
