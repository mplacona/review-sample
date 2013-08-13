require 'factory_girl'

FactoryGirl.define do
    factory :review do
        name "Joe Bloggs"
        text "Some test review"
    end
end
