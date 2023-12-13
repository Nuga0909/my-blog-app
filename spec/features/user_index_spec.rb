require 'rails_helper'

RSpec.feature 'User Index Page' do
  let!(:user1) { User.create(name: 'Assem', bio: 'The best web developer', photo: 'https://avatars.githubusercontent.com/u/127784077?s=400&u=18861529a022fa246f6fc1a684f9831b59131d23&v=4', posts_counter: 0, email: 'assem@example.com', password: 'password') }
  let!(:post1) { Post.create(author: user1, title: 'My first post') }
  let!(:post2) { Post.create(author: user1, title: 'My second post') }

  scenario 'Displays username' do
    visit users_path
    expect(page).to have_content(user1.name)
  end

  scenario 'Displays profile picture' do
    visit users_path
    save_and_open_page
    expect(page).to have_css(".user-photo[src*='#{user1.photo}']")
  end

  scenario 'Displays post counts' do
    visit users_path
    expect(page).to have_content("Number of posts: #{user1.posts_counter}")
  end

  scenario 'Redirects to user show page when clicked' do
    visit users_path
    click_link user1.name
    sleep(5)
    expect(current_path).to eq(user_path(user1))
  end
end
