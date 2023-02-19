require 'rails_helper'

RSpec.describe 'Spots', type: :request do
  describe 'GET /api/v1/spots' do
    before do
      FactoryBot.create_list(:spot, 5)
      get '/api/v1/spots'
    end
    
    it 'returns all spots' do
      expect(JSON.parse(response.body).size).to eq(5)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /api/v1/spots/:id' do
    let!(:spot) { FactoryBot.create(:spot) }

    before do
      get "/api/v1/spots/#{spot.id}"
    end
    
    it 'returns the title' do
      expect(JSON.parse(response.body)['title']).to eq(spot.title)
    end

    it 'returns the description' do
      expect(JSON.parse(response.body)['description']).to eq(spot.description)
    end

    it 'returns the price' do
      expect(JSON.parse(response.body)['price']).to eq(spot.price)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(:success)
    end
  end
end