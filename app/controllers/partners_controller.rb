# frozen_string_literal: true

class PartnersController < ApplicationController
  before_action :set_partner, only: %i[show]

  def index
    response = {}
    render json: response, status: :ok
  end

  def show
    response = {}
    render json: response, status: :ok
  end

  private

  def set_partner
    @partner = Partner.find_by(params.permit(:id))
  end
end
