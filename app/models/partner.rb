class Partner < ApplicationRecord
  scope :with_experience, ->(materials) { where('? = ANY(materials)', materials) }

  scope :within, ->(latitude, longitude) {
    select(%{id, address, materials, rating, ST_Distance(address, 'POINT(%f %f)') as distance} % [longitude, latitude])
      .where(%{
       ST_Distance(address, 'POINT(%f %f)') <= partners.operating_radius * 1000
      } % [longitude, latitude])
      .order('rating desc, distance')
  }

  def address_text
    "#{address.latitude}, #{address.longitude}"
  end
end
