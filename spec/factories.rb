FactoryGirl.define do
  factory :user do
    name     "Michael"
    surname "Hartl"
    pps "1233457R"
    email    "michael@example.com"
    password "foobar"
    password_confirmation "foobar"
  end
end
