require 'rails_helper'
RSpec.feature 'Post Index Page' do
  let!(:user1) { User.create(name: 'Tom', bio: 'Teacher from Mexico.', photo: 'https://avatars.githubusercontent.com/u/98366229?v=4', posts_counter: 0) }
  let!(:post1) do
    Post.create(author_id: user1.id, title: 'Hello', text: 'This is my first post', comments_counter: 0,
                likes_counter: 0)
  end
  let!(:post2) do
    Post.create(author_id: user1.id, title: 'You are welcome', text: 'This is my second post', comments_counter: 0,
                likes_counter: 0)
  end
  let!(:post3) do
    Post.create(author_id: user1.id, title: 'Welcome to the new app', text: 'welcome message', comments_counter: 0,
                likes_counter: 0)
  end
  let!(:post4) do
    Post.create(author_id: user1.id, title: 'this is new post', text: 'i like this', comments_counter: 0,
                likes_counter: 0)
  end
  let!(:comment1) { Comment.create(author: user1, post: post3, body: 'Perfect!') }
  let!(:comment2) { Comment.create(author: user1, post: post1, body: 'Good luck!') }
  let!(:comment3) { Comment.create(author: user1, post: post2, body: 'Never give up!') }
  let!(:comment4) { Comment.create(author: user1, post: post4, body: 'Next, Good job!') }
  scenario 'Displays profile picture' do
    visit user_posts_path(user1)
    expect(page).to have_css("img[src='#{user1.photo}']")
  end
  scenario 'Displays username' do
    visit user_posts_path(user1)
    expect(page).to have_content(user1.name)
  end
  scenario 'Displays posts count' do
    visit user_posts_path(user1)
    expect(page).to have_content("Number Of posts #{user1.posts.count}")
  end
  scenario 'Displays post title' do
    visit user_posts_path(user1)
    expect(page).to have_content(post1.title)
  end
  scenario 'Displays some part of post body' do
    visit user_posts_path(user1)
    expect(page).to have_content(post1.text)
  end
  scenario 'Displays post title' do
    visit user_posts_path(user1)
    expect(page).to have_content(post1.title)
  end
  scenario 'Displays the 1st comment' do
    visit user_posts_path(user1)
    expect(page).to have_content(comment1.body)
  end
  scenario 'Displays comments count' do
    visit user_posts_path(user1)
    expect(page).to have_content("Comments #{post1.comments.count}")
  end
  scenario 'Displays likes count' do
    visit user_posts_path(user1)
    expect(page).to have_content("Likes #{post1.likes.count}")
  end
  scenario 'Displays the pagination if more than 3 posts' do
    visit user_posts_path(user1)
    expect(page).to have_content('Next')
  end
  scenario 'Redirects to post show page when clicked' do
    visit user_posts_path(user1)
    click_link post1.title
    sleep(5)
    expect(current_path).to eq(user_post_path(user1, post1))
  end
end
