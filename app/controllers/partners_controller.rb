# frozen_string_literal: true

class PartnersController < ApplicationController
  before_action :set_partner, only: %i[show]

  def index
    begin
      response = { partners: available_partners }
      render json: response, status: :ok
    rescue ArgumentError
      render json: {}, status: :unprocessable_entity
    end
  end

  def show
    response = {
      address: @partner.address_text,
      rating: @partner.rating,
      materials: @partner.materials
    }
    render json: response, status: :ok
  end

  private

  def available_partners
    partners = if partner_params.empty?
                 Partner.all
               else
                 return FindPartnersService.new(partner_params[:material], partner_params[:lat], partner_params[:lon]).call
               end

    partners.map { |p| { rating: p.rating, materials: p.materials } }
  end

  def partner_params
    params.permit(:material, :lat, :lon, :meters, :phone_number)
  end

  def set_partner
    @partner = Partner.find_by(params.permit(:id))
  end
end
