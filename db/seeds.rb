# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
# wood, carpet, tiles

geo_factory = RGeo::Geographic.spherical_factory(srid: 4326)

partners = [
  {
    materials: ['wood'],
    address: geo_factory.point(13.377775, 52.516266),
    rating: 3,
    operating_radius: 5 # Km
  },
  {
    materials: ['wood', 'tiles'],
    address: geo_factory.point(13.39027, 52.5075),
    rating: 3,
    operating_radius: 6
  },
  {
    materials: ['tiles', 'carpet'],
    address: geo_factory.point(13.409444, 52.520833),
    rating: 4,
    operating_radius: 4
  },
  {
    materials: ['wood'],
    address: geo_factory.point(13.43636, 52.5054076),
    rating: 3,
    operating_radius: 5
  },
  {
    materials: ['wood', 'carpet', 'tiles'],
    address: geo_factory.point(13.2058635, 52.537526),
    rating: 3.5,
    operating_radius: 5
  }
]

Partner.create(partners)
