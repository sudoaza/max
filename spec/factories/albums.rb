FactoryGirl.define do
  factory :album do
    name 'Album name'

    trait :with_songs do
      after(:create) do |album, evaluator|
        songs { create_list :song, 3 }
      end
    end
  end
end
