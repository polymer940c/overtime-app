require 'rails_helper'

describe 'navigate' do
  describe 'index' do
    it 'can be reached successfully' do
      visit posts_path
      expect(page.status_code).to eq(200)
    end
    it 'has a title of posts' do
      visit posts_path
      expect(page).to have_content(/Posts index/)
    end
  end 

  describe 'creation' do
    before do 
      @test_user = User.create( 
        email: 'test@test.test',
        first_name: "john",
        last_name: "snow",
        password: "asdfasdf",
        password_confirmation: "asdfasdf",
      )
      login_as(@test_user, :scope => :user)
      visit new_post_path
    end

    it 'can reach new form' do
      expect(page.status_code).to eq(200)
    end

    it 'can be created on new form page' do 
      fill_in 'post[date]', with: Date.today
      fill_in 'post[rationale]', with: 'rationale'
      click_on 'Save'
      expect(page).to have_content('rationale')
    end
    
    it 'will have a user associated it' do 
      fill_in 'post[date]', with: Date.today
      fill_in 'post[rationale]', with: 'rationale'
      click_on 'Save'

      expect(Post.last.user.id).to eq(@test_user.id)
    end
  end 
end