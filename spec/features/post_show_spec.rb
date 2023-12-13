require 'rails_helper'
RSpec.feature 'Post Show Page' do
  let!(:user1) { User.create(name: 'Assem', bio: 'The best web developer', photo: 'https://avatars.githubusercontent.com/u/127784077?s=400&u=18861529a022fa246f6fc1a684f9831b59131d23&v=4', posts_counter: 0, email: 'assem@example.com', password: 'password') }
  let!(:post1) { Post.create(author_id: user1.id, title: 'My first Post', text: 'I am doing integration specs', comments_counter: 0, likes_counter: 0) }
  let!(:comment1) { Comment.create(user: user1, post: post1, text: 'Good luck!') }
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
    expect(page).to have_content("Comments: #{post1.comments.count}")
  end
  scenario 'Displays likes count' do
    visit user_post_path(user1, post1)
    expect(page).to have_content("Likes: #{post1.likes.count}")
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
    expect(page).to have_content(comment1.text)
  end
end
