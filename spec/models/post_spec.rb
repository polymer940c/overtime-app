require 'rails_helper'

RSpec.describe Post, type: :model do
  describe "Creation" do 
    before do
      user = User.create( 
        email: 'posttest@test.test',
        first_name: "john",
        last_name: "snow",
        password: "asdfasdf",
        password_confirmation: "asdfasdf",
      )
      @post = Post.create( date: Date.today, rationale: "what is rationale", user_id: user.id) 
    end
    it "can be created" do 
      expect(@post).to be_valid
    end
    it "cant not be created if the date and rationale is empty" do 
      @post.date = nil 
      @post.rationale = nil 
      expect(@post).to_not be_valid
    end
  end
end 
