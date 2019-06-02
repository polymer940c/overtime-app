require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.create(:user)
  end

  describe "Creation" do 
    it "can create user" do 
      expect(@user).to be_valid
    end
    it "can not be created w/o first_name, last_name" do 
      @user.first_name = nil
      @user.last_name = nil
      expect(@user).to_not be_valid
    end  
  end

  describe "Custom methods" do 
    it "can get user full name" do 
      expect(@user.full_name).to eq(@user.first_name.capitalize + " " + @user.last_name.capitalize)
    end
  end

end
