require 'rails_helper'

RSpec.feature 'User Show Page' do
  let!(:user1) { User.create(name: 'Assem', bio: 'The best web developer', photo: 'https://avatars.githubusercontent.com/u/127784077?s=400&u=18861529a022fa246f6fc1a684f9831b59131d23&v=4', posts_counter: 0, email: 'assem@example.com', password: 'password') }
  let!(:post1) { Post.create(author: user1, title: 'My first post') }
  let!(:post2) { Post.create(author: user1, title: 'My second post') }
  let!(:post3) { Post.create(author: user1, title: 'My third post') }
  let!(:post4) { Post.create(author: user1, title: 'My forth post') }

  scenario 'Displays profile pictures' do
    visit user_path(user1)
    expect(page).to have_css("img[src='#{user1.photo}']")
  end

  scenario 'Displays usernames' do
    visit user_path(user1)
    expect(page).to have_content(user1.name)
  end

  scenario 'Displays post counts' do
    visit user_path(user1)
    expect(page).to have_content("Number of posts: #{user1.posts.count}")
  end

  scenario 'Displays user bio' do
    visit user_path(user1)
    expect(page).to have_content(user1.bio)
  end

  scenario 'Displays the first 3 posts' do
    visit user_path(user1)
    user1.posts.limit(3).each do |post|
      expect(page).to have_content(post.title)
    end
  end

  scenario 'Displays the button to see all posts' do
    visit user_path(user1)
    expect(page).to have_button('See all posts')
  end

  scenario 'Redirects to post show page when clicked' do
    visit user_path(user1)
    click_link post1.title
    sleep(5)
    expect(current_path).to eq(user_post_path(user1, post1))
  end

  scenario 'Redirects to post index page when clicked' do
    visit user_path(user1)
    click_button 'See all posts'
    sleep(5)
    expect(current_path).to eq(user_posts_path(user1))
  end
end
