require 'rails_helper'

describe 'navigate' do
  let(:test_user) { FactoryBot.create(:user) }
  let(:test_user_post) do
    Post.create(
      date: Date.today,
      rationale: "Rationale",
      user_id: test_user.id,
    )
  end

  before do
    login_as(test_user, :scope => :user)
  end

  describe 'index' do
    before do
      visit posts_path
    end

    it 'can be reached successfully' do
      expect(page.status_code).to eq(200)
    end
    it 'has a title of posts' do
      expect(page).to have_content(/Posts index/)
    end
    it 'has a list of posts' do
      FactoryBot.create(:post)
      FactoryBot.create(:second_post)
      visit posts_path
      expect(page).to have_content(/firstpost|secondpost/)
    end
  end

  describe 'creation' do
    before do
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

      expect(test_user_post.user.id).to eq(test_user.id)
    end
  end

  describe 'edit' do
    before do
      @rando_user = User.create(
        first_name: Faker::Name.first_name,
        last_name: Faker::Name.last_name,
        email: "rando@test.test",
        password: "asdfasdf",
        password_confirmation: "asdfasdf"
      )
      login_as(@rando_user, :scope => :user)
      @rando_user_post = Post.create(date: Date.today, rationale: "asdf", user_id: @rando_user.id)
    end

    it 'can edit post' do
      visit edit_post_path(@rando_user_post)
      fill_in 'post[date]', with: Date.today
      fill_in 'post[rationale]', with: 'new rationale'
      click_on 'Save'
      expect(page).to have_content('new rationale')
    end

    it 'will not allow post to be edit if current user is not owner or admin' do
      user_with_posts = FactoryBot.create(:user_with_posts)
      visit edit_post_path(user_with_posts.posts.first)
      expect(current_path).to eq(root_path)
    end

  end

  describe "new" do
    it 'can be reach on the home page' do
      visit posts_path
      click_link('new_post_from_nav')
      expect(page.status_code).to eq(200)
    end
  end

  describe 'delete' do
    it 'can be deleted' do
      @post = FactoryBot.create(:post)

      visit posts_path
      click_link("delete_post_#{@post.id}_from_index")
      expect(page.status_code).to eq(200)
    end
  end

end