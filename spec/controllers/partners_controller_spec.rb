require 'rails_helper'

RSpec.describe PartnersController do
  describe '#index' do
    before do
      create(:partner, :checkpoint_charlie, rating: 4)
      create(:partner, :fernsehturm, :wood, rating: 3)
      create(:partner, :tiles, rating: 2)
    end

    context 'with no params' do
      before do
        get :index, params: { }
      end

      it 'returns available partners' do
        actual_response = JSON.parse(response.body).deep_symbolize_keys
        expected_response = {
          partners: [
            {
              materials: ['wood', 'carpet', 'tiles'],
              rating: 4
            },
            {
              materials: ['wood'],
              rating: 3
            },
            {
              materials: ['tiles'],
              rating: 2
            }
          ],
        }

        expect(actual_response).to have_key(:partners)
        expect(actual_response[:partners].size).to eq(3)
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

        expect(actual_response).to eq(expected_response)
      end
    end
  end
end
