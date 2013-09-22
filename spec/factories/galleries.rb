# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :gallery do
    name "MyString"
    description "MyText"
    date_start "2013-09-21"
    date_end "2013-09-21"
  end
end
