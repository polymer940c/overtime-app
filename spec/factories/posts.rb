FactoryBot.define do
  factory :post do
    user
    date {Date.today}
    rationale {"firstpost rationale"}
  end
  factory :second_post, class: "Post" do
    user
    date {Date.yesterday}
    rationale {"secondpost more content"}
  end
end