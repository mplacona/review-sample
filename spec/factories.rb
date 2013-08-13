require 'factory_girl'

FactoryGirl.define do
    # Normal review
    factory :review do
        name "Joe Bloggs"
        text "Some test review"
    end
    
    # A review being updated
    factory :review1 do
        name "Joe Bloggs"
        text "I like reviewing this"
    end
end
