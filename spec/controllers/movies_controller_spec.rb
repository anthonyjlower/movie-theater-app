require 'rails_helper'

RSpec.describe MoviesController, type: :controller do
  before(:each) do
    create(:transaction)
  end

  describe 'GET #index' do
    it 'has a 200 status code' do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET #show' do
    it 'has a 200 status code' do
      get :show, params: { id: Movie.first.id }
      expect(response).to have_http_status(:success)
    end
  end
end
