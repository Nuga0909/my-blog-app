require 'rails_helper'
RSpec.feature 'Post Show Page' do
  let!(:user1) { User.create(name: 'Tom', bio: 'Teacher from Mexico.', photo: 'https://avatars.githubusercontent.com/u/98366229?v=4', posts_counter: 0) }
  let!(:post1) { Post.create(author_id: user1.id, title: 'Hello', text: 'This is my first post', comments_counter: 0, likes_counter: 0) }
  let!(:comment1) { Comment.create(author: user1, post: post1, body: 'Perfect!') }
  scenario 'Displays post title' do
    visit user_post_path(user1, post1)
    expect(page).to have_content(post1.title)
  end
  scenario 'Displays post author' do
    visit user_post_path(user1, post1)
    expect(page).to have_content(user1.name)
  end
  scenario 'Displays comments count' do
    visit user_post_path(user1, post1)
    expect(page).to have_content("Comments #{post1.comments.count}")
  end
  scenario 'Displays likes count' do
    visit user_post_path(user1, post1)
    expect(page).to have_content("Likes #{post1.likes.count}")
  end
  scenario 'Displays the post body' do
    visit user_post_path(user1, post1)
    expect(page).to have_content(post1.text)
  end
  scenario 'Displays the comment author' do
    visit user_post_path(user1, post1)
    expect(page).to have_content(user1.name)
  end
  scenario 'Displays the comment text' do
    visit user_post_path(user1, post1)
    expect(page).to have_content(comment1.body)
  end
end
