require 'rails_helper'

RSpec.describe 'Reviews', type: :request do
  describe 'PUT /api/v1/spots/:spot_id/reviews/:id' do
    context 'with valid parameters' do
      let!(:spot) { FactoryBot.create(:spot) }
      let!(:review) { FactoryBot.create(:review, spot_id: spot.id) }

      before do
        put "/api/v1/spots/#{spot.id}/reviews/#{review.id}", params:
                          { review: {
                            name: review.name + 'updated',
                            comment: review.comment + 'updated'
                          } }
      end

      it 'returns the name' do
        expect(JSON.parse(response.body)['name']).to eq(review.name + 'updated')
      end
  
      it 'returns the comment' do
        expect(JSON.parse(response.body)['comment']).to eq(review.comment + 'updated')
      end
    end

    context 'with invalid parameters' do
      let!(:spot) { FactoryBot.create(:spot) }
      let!(:review) { FactoryBot.create(:review, spot_id: spot.id) }

      it 'returns a unprocessable entity status' do
        put "/api/v1/spots/#{spot.id}/reviews/#{review.id}", params:
                          { review: {
                            name: '',
                            comment: '',
                            point: ''
                          } }
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'point must be greater than or equal to 1' do
        put "/api/v1/spots/#{spot.id}/reviews/#{review.id}", params:
                          { review: {
                            name: 'Review 1',
                            comment: 'Comment 1',
                            point: 0
                          } }
        expect(JSON.parse(response.body)['point'].first).to eq('must be greater than or equal to 1')
      end

      it 'point must be less than or equal to 5' do
        put "/api/v1/spots/#{spot.id}/reviews/#{review.id}", params:
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