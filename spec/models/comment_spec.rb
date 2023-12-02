require 'rails_helper'

RSpec.describe Comment, type: :model do
  let(:user) { User.create(name: 'John', posts_counter: 0) }
  let(:post) { Post.create(author: user, title: 'Post', comments_counter: 0, likes_counter: 0) }

  it 'is valid with valid attributes' do
    comment = Comment.new(author: user, post: post)
    expect(comment).to be_valid
  end

  it 'increments the post comments_counter after creation' do
    expect { Comment.create(author: user, post: post) }
      .to change { post.reload.comments_counter }.by(1)
  end
end
