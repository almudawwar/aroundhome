class Partner < ApplicationRecord
  scope :with_experience, ->(materials) { where('? = ANY(materials)', materials) }

  scope :within, ->(latitude, longitude) {
    where(%{
     ST_Distance(address, 'POINT(%f %f)') <= partners.operating_radius * 1000
    } % [longitude, latitude])
  }

  def address_text
    "#{address.latitude}, #{address.longitude}"
  end
end
