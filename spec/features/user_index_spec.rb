require 'rails_helper'

RSpec.feature 'User Index Page' do
  let!(:user1) { User.create(name: 'Tom', bio: 'Teacher from Mexico.', photo: 'https://avatars.githubusercontent.com/u/98366229?v=4', posts_counter: 0) }
  let!(:post1) { Post.create(author: user1, title: 'Hello') }
  let!(:post2) { Post.create(author: user1, title: 'You are welcome') }

  scenario 'Displays username' do
    visit users_path
    expect(page).to have_content(user1.name)
  end

  scenario 'Displays profile picture' do
    visit users_path
    expect(page).to have_css("img[src='#{user1.photo}']")
  end

  scenario 'Displays post counts' do
    visit users_path
    expect(page).to have_content("Number Of posts #{user1.posts_counter}")
  end

  scenario 'Redirects to user show page when clicked' do
    visit users_path
    click_link user1.name
    sleep(5)
    expect(current_path).to eq(user_path(user1))
  end
end
