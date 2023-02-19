require 'rails_helper'

RSpec.describe 'Reviews', type: :request do
  describe 'GET /api/v1/spots/:spot_id/reviews/' do
    let!(:spot) { FactoryBot.create(:spot) }
    let!(:reviews) { FactoryBot.create_list(:review, 5) }

    before do
      get "/api/v1/spots/#{spot.id}/reviews"
    end
    
    it 'returns all reviews' do
      expect(JSON.parse(response.body).size).to eq(5)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /api/v1/spots/:spot_id/reviews' do
    let!(:spot) { FactoryBot.create(:spot) }
    let!(:review) { FactoryBot.create_list(:review, 5).first }

    before do
      get "/api/v1/spots/#{spot.id}/reviews/#{review.id}"
    end
    
    it 'returns the name' do
      expect(JSON.parse(response.body)['name']).to eq(review.name)
    end

    it 'returns the comment' do
      expect(JSON.parse(response.body)['comment']).to eq(review.comment)
    end

    it 'returns the point' do
      expect(JSON.parse(response.body)['point']).to eq(review.point)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(:success)
    end
  end
end