require 'rails_helper'

RSpec.describe Post, type: :model do
  describe "Creation" do 
    subject { Post.create( date: Date.today, rationale: "what is rationale") }
    it "can be created" do 
      expect(subject).to be_valid
    end
    it "cant not be created if the date and rationale is empty" do 
      subject.date = nil 
      subject.rationale = nil 
      expect(subject).to_not be_valid
    end
  end
end 
