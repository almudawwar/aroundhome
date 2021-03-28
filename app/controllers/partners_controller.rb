# frozen_string_literal: true

class PartnersController < ApplicationController
  before_action :set_partner, only: %i[show]

  def index
    response = { partners: available_partners }
    render json: response, status: :ok
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
    if partner_params.empty?
      Partner.all
    else
      Partner.with_experience(partner_params[:material]).within(partner_params[:lat], partner_params[:lon])
    end
  end

  def partner_params
    params.permit(:material, :lat, :lon, :meters, :phone_number)
  end

  def set_partner
    @partner = Partner.find_by(params.permit(:id))
  end
end
