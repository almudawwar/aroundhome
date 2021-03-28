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
            id: partner.id,
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
          expected_ids= [partner_rating_5.id, partner.id, partner_rating_3.id, partner_rating_2.id]
          response = service.call
          ids = response.map { |p| p[:id] }

          expect(ids).to eq(expected_ids)
        end
      end

      context 'with multiple partners available with different distances' do
        let(:partner_2) { create(:partner, :checkpoint_charlie, :wood, rating: 4) }
        let(:partner_3) { create(:partner, :east_side_gallery, :wood, rating: 4) }

        it 'returns partners ordered by distance' do
          expected_ids= [partner.id, partner_2.id, partner_3.id]
          response = service.call
          ids = response.map { |p| p[:id] }

          expect(ids).to eq(expected_ids)
        end
      end

      context 'with multiple partners available with different distances and ratings' do
        let(:partner_rating_3_charlie) { create(:partner, :checkpoint_charlie, :wood, rating: 3) }
        let(:partner_rating_5_gallery) { create(:partner, :east_side_gallery, :wood, rating: 5) }
        let(:partner_rating_5_charlie) { create(:partner, :checkpoint_charlie, :wood, rating: 5) }

        it 'returns partners ordered by rating and distance' do
          expected_ids= [partner_rating_5_charlie.id, partner_rating_5_gallery.id, partner.id, partner_rating_3_charlie.id]
          response = service.call
          ids = response.map { |p| p[:id] }

          expect(ids).to eq(expected_ids)
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
