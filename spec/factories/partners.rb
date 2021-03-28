FactoryBot.define do
  factory :partner do
    materials { ['wood', 'carpet', 'tiles'] }
    address { 'POINT (52.516266 13.377775)' }
    rating { rand(0..5) }
    operating_radius { rand(0..10) }
  end

  trait :checkpoint_charlie do
    address { 'POINT (52.5075 13.39027)' }
  end

  trait :fernsehturm do
    address { 'POINT (52.520833 13.409444)' }
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
