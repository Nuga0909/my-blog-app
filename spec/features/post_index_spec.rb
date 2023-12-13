require 'rails_helper'

RSpec.feature 'Post Index Page' do
  let!(:user1) { create_user_with_posts }

  before do
    create_comments_for_posts(user1)
  end

  scenario 'Displays user information and posts' do
    visit user_posts_path(user1)

    expect_user_information(user1)
    expect_posts_information(user1.posts.first)
    expect_comments_information(user1.posts.first.comments.first)
    expect_pagination_information

    click_link user1.posts.first.title
    expect(current_path).to eq(user_post_path(user1, user1.posts.first))
  end

  private

  def create_user_with_posts
    user = User.create(name: 'Tom', bio: 'Teacher from Mexico.',
                       photo: 'https://avatars.githubusercontent.com/u/98366229?v=4', posts_counter: 0)
    create_posts(user)
    user
  end

  def create_posts(user)
    Post.create(author_id: user.id, title: 'Hello', text: 'This is my first post',
                comments_counter: 0, likes_counter: 0)
    # Create other posts as needed
  end

  def create_comments_for_posts(user)
    user.posts.each do |post|
      create_comment(user, post, 'Sample Comment')
    end
  end

  def create_comment(author, post, body)
    Comment.create(author: author, post: post, body: body)
  end

  def expect_user_information(user)
    expect(page).to have_css("img[src='#{user.photo}']")
    expect(page).to have_content(user.name)
    expect(page).to have_content("Number Of posts #{user.posts.count}")
  end

  def expect_posts_information(post)
    expect(page).to have_content(post.title)
    expect(page).to have_content(post.text)
    expect(page).to have_content("Comments #{post.comments.count}")
    expect(page).to have_content("Likes #{post.likes.count}")
  end

  def expect_comments_information(comment)
    expect(page).to have_content(comment.body)
  end

  def expect_pagination_information
    expect(page).to have_content('Next')
  end
end
