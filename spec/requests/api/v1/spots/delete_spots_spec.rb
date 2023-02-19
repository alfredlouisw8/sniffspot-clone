require 'rails_helper'

RSpec.describe 'Spots', type: :request do
  describe "DELETE /api/v1/spots/:id" do
    let!(:spot) { FactoryBot.create(:spot) }

    before do
      delete "/api/v1/spots/#{spot.id}"
    end

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end