FactoryBot.define do
  factory :partner do
    materials { ['wood', 'carpet', 'tiles'] }
    address { 'POINT (13.377775 52.516266)' }
    rating { rand(0..5) }
    operating_radius { rand(0..10) }
  end

  trait :checkpoint_charlie do
    address { 'POINT (13.39027 52.5075)' }
  end

  trait :fernsehturm do
    address { 'POINT (13.409444 52.520833)' }
  end

  trait :east_side_gallery do
    address { 'POINT (13.43636 52.5054076)' }
  end

  trait :spandau do
    address { 'POINT (13.2058635 52.537526)' }
  end

  trait :wood do
    materials { ['wood'] }
  end

  trait :carpet do
    materials { ['carpet'] }
  end

  trait :tiles do
    materials { ['tiles'] }
  end
end
