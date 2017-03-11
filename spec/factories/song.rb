FactoryGirl.define do
  factory :song do
    name "Le song name"
    duration 123

    trait :different do
      name "Song 2"
      duration 456
    end

    trait :rock do
      name "House of the Rising Sun"
      association :genre, :rock
    end
  end
end
