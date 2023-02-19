require 'rails_helper'

RSpec.describe 'Spots', type: :request do
  describe 'POST /api/v1/spots/' do
    context 'with valid parameters' do
      let!(:spot) { FactoryBot.create(:spot) }

      before do
        post '/api/v1/spots', params:
                          { spot: {
                            title: spot.title,
                            description: spot.description,
                            price: spot.price,
                            images: [fixture_file_upload(file_fixture('image1.webp'))]
                          } }
        
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

      it 'returns the images' do
        expect(JSON.parse(response.body)['images'].length).to eq(1)
      end

      it 'returns a created status' do
        expect(response).to have_http_status(:created)
      end
    end

    context 'with invalid parameters' do
      before do
        post '/api/v1/spots', params:
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