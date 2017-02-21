FactoryGirl.define do
  factory :user do
    password "password"
    password_confirmation "password"
    sequence :email do |n|
      "example#{n}@email.com"
    end
  end
end
