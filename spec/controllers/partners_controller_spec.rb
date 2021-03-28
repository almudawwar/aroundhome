require 'rails_helper'

RSpec.describe PartnersController do
  describe '#index' do
    context 'with no params' do
      before do
        create(:partner, :checkpoint_charlie, rating: 4)
        create(:partner, :fernsehturm, :wood, rating: 3)
        create(:partner, :tiles, rating: 2)
      end

      it 'returns unprocessable_entity' do
        get :index
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end

    context 'within range and materials' do
      let(:partner) { create(:partner, :fernsehturm, :wood) }

      before do
        create_list(:partner, 4, :spandau) # out of reach
        get :index, params: { lat: partner.address.latitude, lon: partner.address.longitude, material: 'wood' }
      end

      it 'returns successful response' do
        actual_response = JSON.parse(response.body).deep_symbolize_keys
        expect(response).to have_http_status(:ok)
        expect(actual_response).to have_key(:partners)
      end
    end

    context 'within range but not materials' do
      let(:partner) { create(:partner, :fernsehturm, :wood) }

      before do
        create_list(:partner, 4, :spandau) # out of reach
        get :index, params: { lat: partner.address.latitude, lon: partner.address.longitude, material: 'not_a_material' }
      end

      it 'returns no partners' do
        actual_response = JSON.parse(response.body).deep_symbolize_keys

        expect(response).to have_http_status(:ok)
        expect(actual_response).to have_key(:partners)
      end
    end

    context 'outside range' do
      before do
        create_list(:partner, 4, :spandau) # out of reach
        get :index, params: { lat: 52.520833, lon: 13.409444, material: 'wood' }
      end

      it 'returns no partners' do
        actual_response = JSON.parse(response.body).deep_symbolize_keys

        expect(response).to have_http_status(:ok)
        expect(actual_response).to have_key(:partners)
      end
    end
  end

  describe '#show' do
    let(:partner) { create(:partner, :checkpoint_charlie, rating: 4) }

    context 'with valid id' do
      before do
        get :show, params: { id: partner.id }
      end

      it 'returns partner info' do
        actual_response = JSON.parse(response.body).deep_symbolize_keys
        expected_response = {
          address: '52.5075, 13.39027',
          rating: 4.0,
          materials: ['wood', 'carpet', 'tiles']
        }

        expect(response).to have_http_status(:ok)
        expect(actual_response).to eq(expected_response)
      end
    end
  end
end
