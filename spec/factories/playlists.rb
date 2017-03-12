FactoryGirl.define do
  factory :playlist do
    name 'My test playlist'

    trait :with_songs do
      after(:create) do |playlist, evaluator|
        songs { create_list :song, 3 }
      end
    end
  end
end
