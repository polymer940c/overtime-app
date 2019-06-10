require 'faker'
FactoryBot.define do
  sequence :email do |n|
    "person#{n}@example.com"
  end

  factory :user do
    first_name { Faker::Name.first_name } 
    last_name { Faker::Name.last_name }
    email
    password {"asdfasdf"}
    password_confirmation {"asdfasdf"}

    factory :user_with_posts do 
      transient do
        posts_count { 5 }
      end
      after(:create) do |user, evaluator|
        create_list(:post, evaluator.posts_count, user: user)
      end
    end
  end

  factory :non_authorized_user, class: "User" do
    first_name { Faker::Name.first_name } 
    last_name { Faker::Name.last_name }
    email
    password {"asdfasdf"}
    password_confirmation {"asdfasdf"}
  end

  factory :admin_user, class: "AdminUser" do
    first_name {"admin"}
    last_name {"user"}
    email {"admin@user.com"}       
    password {"asdfasdf"}
    password_confirmation {"asdfasdf"}
  end


end