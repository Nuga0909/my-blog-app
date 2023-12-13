require 'rails_helper'

RSpec.feature 'Post Index Page' do
  let!(:user1) do
    User.create(name: 'Tom', bio: 'Teacher from Mexico.', photo: 'https://avatars.githubusercontent.com/u/98366229?v=4', posts_counter: 0)
  end

  let!(:post1) { create_post(user1, 'Hello', 'This is my first post') }
  let!(:post2) { create_post(user1, 'You are welcome', 'This is my second post') }
  let!(:post3) { create_post(user1, 'Welcome to the new app', 'Tis is a welcome message to the new blog app') }
  let!(:post4) { create_post(user1, 'this is new post', 'i like this') }

  let!(:comment1) { create_comment(user1, post3, 'Perfect!') }

  before do
    create_comment(user1, post1, 'Good luck!')
    create_comment(user1, post2, 'Never give up!')
    create_comment(user1, post4, 'Next, Good job!')
  end

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
    expect(current_path).to eq(user_post_path(user1, post1))
  end

  private

  def create_post(author, title, text)
    Post.create(author_id: author.id, title: title, text: text, comments_counter: 0, likes_counter: 0)
  end

  def create_comment(author, post, body)
    Comment.create(author: author, post: post, body: body)
  end
end
