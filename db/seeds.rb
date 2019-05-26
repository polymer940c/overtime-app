100.times do |n|
  Post.create!(date: Date.today, rationale: "#{n} rationale content")
end
puts "100 Posts have been created"