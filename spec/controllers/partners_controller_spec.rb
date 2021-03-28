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

  end
end
