require 'rails_helper'

RSpec.describe 'Reviews', type: :request do
  describe "DELETE /api/v1/spots/:spot_id/reviews/:id" do
    let!(:spot) { FactoryBot.create(:spot) }
    let!(:review) { FactoryBot.create(:review, spot_id: spot.id) }

    before do
      delete "/api/v1/spots/#{spot.id}/reviews/#{review.id}"
    end

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end