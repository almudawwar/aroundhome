class FindPartnersService
  attr_reader :material, :lat, :lon

  def initialize(material, lat, lon)
    @material = material
    @lat = lat
    @lon = lon

    raise StandardError if missing_argument?
  end

  def call
    Partner.with_experience(material).within(lat, lon)
      .map { |p| { rating: p.rating, materials: p.materials } }
  end

  private

  def missing_argument?
    material.nil? || lat.nil? || lon.nil?
  end
end
