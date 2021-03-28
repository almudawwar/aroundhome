require 'rails_helper'

RSpec.describe FindPartnersService, type: :service do
  describe '#call' do

    context 'within range and materials' do
      subject(:service) { described_class.new('wood', partner.address.latitude, partner.address.longitude) }

      let(:partner) { create(:partner, :fernsehturm, :wood, rating: 4) }

      before do
        create_list(:partner, 4, :spandau) # out of reach
      end

      it 'returns one partner' do
        expected_response = [
          {
            materials: ['wood'],
            rating: partner.rating
          }
        ]

        expect(service.call).to eq(expected_response)
      end

      context 'with multiple partners available with different ratings' do
        let(:partner_rating_2) { create(:partner, :fernsehturm, :wood, rating: 2) }
        let(:partner_rating_3) { create(:partner, :fernsehturm, :wood, rating: 3) }
        let(:partner_rating_5) { create(:partner, :fernsehturm, :wood, rating: 5) }

        it 'returns partners ordered by rating' do
          expected_ratings= [partner_rating_5.rating, partner.rating, partner_rating_3.rating, partner_rating_2.rating]
          response = service.call
          ratings = response.map { |p| p[:rating] }

          expect(ratings).to eq(expected_ratings)
        end
      end

      context 'with multiple partners available with different distances' do
        let(:partner_rating_2) { create(:partner, :checkpoint_charlie, :wood, rating: 4) }
        let(:partner_rating_3) { create(:partner, :east_side_gallery, :wood, rating: 4) }

        it 'returns partners ordered by distance' do
          expected_ratings= [partner.rating, partner_rating_2.rating, partner_rating_3.rating]
          response = service.call
          ratings = response.map { |p| p[:rating] }

          expect(ratings).to eq(expected_ratings)
        end
      end

      context 'with multiple partners available with different distances and ratings' do
        let!(:partner_rating_2) { create(:partner, :checkpoint_charlie, :wood, rating: 3) }
        let!(:partner_rating_3) { create(:partner, :east_side_gallery, :wood, rating: 5) }

        it 'returns partners ordered by rating and distance' do
          expected_ratings= [partner_rating_3.rating, partner.rating, partner_rating_2.rating]
          response = service.call
          ratings = response.map { |p| p[:rating] }

          expect(ratings).to eq(expected_ratings)
        end
      end
    end

    context 'within range but not materials' do
      subject(:service) { described_class.new('not_a_material', partner.address.latitude, partner.address.longitude) }

      let(:partner) { create(:partner, :fernsehturm, :wood) }

      it 'returns no partners' do
        expected_response = []

        expect(service.call).to eq(expected_response)
      end
    end

    context 'outside range' do
      subject(:service) { described_class.new('wodd', 52.520833, 13.409444) }

      before do
        create_list(:partner, 4, :spandau) # out of reach
      end

      it 'returns no partners' do
        expected_response = []

        expect(service.call).to eq(expected_response)
      end
    end
  end
end
