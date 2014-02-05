FactoryGirl.define do
  factory :user do
    email "factorygirl@example.com"
    password "password"
  end

  factory :profile do
    html "<p>factorygirl</p>"
  end
end
