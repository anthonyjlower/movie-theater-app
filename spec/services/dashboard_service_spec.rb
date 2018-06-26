require 'rails_helper'

RSpec.describe DashboardService, type: :service do
  describe 'Instance Methods' do
    let(:transactions) { [create(:transaction), create(:transaction)] }
    subject { DashboardService.new }

    describe 'total_rev' do
      it 'should return the sum of all transactions' do
        sum = transactions[0].cost + transactions[1].cost
        expect(subject.total_rev).to eq(sum)
      end
    end

    describe 'daily_sales' do
      it 'should have keys corresponding to days' do
        keys = transactions.map { |t| Date::DAYNAMES[t.showing.date.wday]}.uniq
        expect(subject.daily_sales.keys).to eq(keys)
      end

      it 'should have values equalling total sales' do
        sum = transactions.map { |t| t.cost }.sum
        expect(subject.daily_sales.values.sum).to eq(sum)
      end
    end

    describe 'hourly_sales' do
      it 'should have keys corresponding to times' do
        keys = transactions.map { |t| t.showing.time }.uniq
        expect(subject.hourly_sales.keys).to eq(keys)
      end

       it 'should have values equalling total sales' do
        sum = transactions.map { |t| t.cost }.sum
        expect(subject.daily_sales.values.sum).to eq(sum)
      end
    end

    describe 'movie_sales' do
      it 'should have keys corresponding to movies' do
        keys = transactions.map { |t| t.showing.movie.title }.uniq
        expect(subject.movie_sales.keys).to eq(keys)
      end

       it 'should have values equalling total sales' do
        sum = transactions.map { |t| t.cost }.sum
        expect(subject.daily_sales.values.sum).to eq(sum)
      end
    end
  end
end
