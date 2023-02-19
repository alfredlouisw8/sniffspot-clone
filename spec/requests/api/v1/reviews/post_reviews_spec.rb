require 'rails_helper'

RSpec.describe 'Reviews', type: :request do
  describe 'POST /api/v1/spots/:spot_id/reviews' do
    context 'with valid parameters' do
      let!(:spot) { FactoryBot.create(:spot) }
      let!(:review) { FactoryBot.create(:review, spot_id: spot.id) }

      before do
        post "/api/v1/spots/#{spot.id}/reviews", params:
                          { review: {
                            name: review.name,
                            comment: review.comment,
                            point: review.point,
                            spot_id: spot.id
                          } }
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

      it 'returns a created status' do
        expect(response).to have_http_status(:created)
      end
    end

    context 'with invalid parameters' do
      let!(:spot) { FactoryBot.create(:spot) }

      it 'returns a unprocessable entity status' do
        post "/api/v1/spots/#{spot.id}/reviews", params:
                          { review: {
                            name: '',
                            comment: '',
                            point: ''
                          } }
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'point must be greater than or equal to 1' do
        post "/api/v1/spots/#{spot.id}/reviews", params:
                          { review: {
                            name: 'Review 1',
                            comment: 'Comment 1',
                            point: 0
                          } }
        expect(JSON.parse(response.body)['point'].first).to eq('must be greater than or equal to 1')
      end

      it 'point must be less than or equal to 5' do
        post "/api/v1/spots/#{spot.id}/reviews", params:
                          { review: {
                            name: 'Review 1',
                            comment: 'Comment 1',
                            point: 6
                          } }
        expect(JSON.parse(response.body)['point'].first).to eq('must be less than or equal to 5')
      end
    end
  end
end