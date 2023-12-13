require 'rails_helper'

RSpec.feature 'Post Show Page' do
  let!(:user1) do
    User.create(name: 'Tom', bio: 'Teacher from Mexico.', photo: 'https://avatars.githubusercontent.com/u/98366229?v=4', posts_counter: 0)
  end

  let!(:post1) { create_post(user1, 'Hello', 'This is my first post') }
  let!(:comment1) { create_comment(user1, post1, 'Perfect!') }

  scenario 'Displays post details' do
    visit user_post_path(user1, post1)

    expect(page).to have_content(post1.title)
    expect(page).to have_content(user1.name)
    expect(page).to have_content("Comments #{post1.comments.count}")
    expect(page).to have_content("Likes #{post1.likes.count}")
    expect(page).to have_content(post1.text)
    expect(page).to have_content(user1.name)
    expect(page).to have_content(comment1.body)
  end

  private

  def create_post(author, title, text)
    Post.create(author_id: author.id, title: title, text: text, comments_counter: 0, likes_counter: 0)
  end

  def create_comment(author, post, body)
    Comment.create(author: author, post: post, body: body)
  end
end
