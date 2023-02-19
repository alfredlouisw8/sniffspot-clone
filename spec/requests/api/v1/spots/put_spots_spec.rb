require 'rails_helper'

RSpec.describe 'Spots', type: :request do
  describe 'PUT /api/v1/spots/:id' do
    context 'with valid parameters' do
      let!(:spot) { FactoryBot.create(:spot) }

      before do
        put "/api/v1/spots/#{spot.id}", params:
                          { spot: {
                            title: spot.title + 'updated',
                            description: spot.description + 'updated',
                            price: spot.price + 10,
                            images: [fixture_file_upload(file_fixture('image1.webp')), fixture_file_upload(file_fixture('image2.webp'))]
                          } }
      end

      it 'returns the title' do
        expect(JSON.parse(response.body)['title']).to eq(spot.title + 'updated')
      end

      it 'returns the description' do
        expect(JSON.parse(response.body)['description']).to eq(spot.description + 'updated')
      end

      it 'returns the price' do
        expect(JSON.parse(response.body)['price']).to eq(spot.price + 10)
      end

      it 'returns the images' do
        expect(JSON.parse(response.body)['images'].length).to eq(2)
      end
    end

    context 'with invalid parameters' do

      let!(:spot) { FactoryBot.create(:spot) }

      before do
        put "/api/v1/spots/#{spot.id}", params:
                          { spot: {
                            title: '',
                            description: ''
                          } }
      end

      it 'returns a unprocessable entity status' do
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end
end