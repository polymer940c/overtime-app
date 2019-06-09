require 'rails_helper'
describe "approval work flow" do 
  before do 
    @post = FactoryBot.create(:post)
  end

  describe "as an admin" do 
    before do
      @admin_user = FactoryBot.create(:admin_user)
      login_as(@admin_user, :scope => :user)
    end
    describe 'edit' do 
      it 'can be edited by admin' do 
        visit edit_post_path(@post)
        choose('post_status_approved')
        click_on('Save')
        expect(@post.reload.status).to eq('approved') 
      end
    end
  end
  
  describe "as a regular joe" do 
    before do
      regular_joe = FactoryBot.create(:user)
      login_as(regular_joe, :scope => :user)
    end
    describe 'edit' do
      it 'can not be edited by regular joe' do 
        visit edit_post_path(@post)
        expect(page).to_not have_content('Approved')
      end
    end
  end



end