require 'rails_helper'

RSpec.feature 'User Show Page' do
  let!(:user1) do
    User.create(name: 'Tom', bio: 'Teacher from Mexico.',
                photo: 'https://avatars.githubusercontent.com/u/98366229?v=4', posts_counter: 0)
  end

  let!(:post1) { create_post(user1, 'My first post') }
  let!(:post2) { create_post(user1, 'My second post') }
  let!(:post3) { create_post(user1, 'My third post') }
  let!(:post4) { create_post(user1, 'My forth post') }

  scenario 'Displays user details' do
    visit user_path(user1)

    expect(page).to have_css("img[src='#{user1.photo}']")
    expect(page).to have_content(user1.name)
    expect(page).to have_content("Number Of posts #{user1.posts.count}")
    expect(page).to have_content(user1.bio)

    user1.posts.limit(3).each do |post|
      expect(page).to have_content(post.title)
    end

    expect(page).to have_content('View All Posts')
  end

  scenario 'Redirects to post show page when post title clicked' do
    visit user_path(user1)
    click_link post1.title
    expect(current_path).to eq(user_post_path(user1, post1))
  end

  scenario 'Redirects to post index page when "View All Posts" clicked' do
    visit user_path(user1)
    click_link 'View All Posts'
    expect(current_path).to eq(user_posts_path(user1))
  end

  private

  def create_post(author, title)
    Post.create(author:, title:)
  end
end
