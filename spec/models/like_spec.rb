require 'rails_helper'

RSpec.describe Like, type: :model do
  let(:user) { User.create(name: 'John', posts_counter: 0) }
  let(:post) { Post.create(author: user, title: 'Post', comments_counter: 0, likes_counter: 0) }

  it 'is valid with valid attributes' do
    like = Like.new(author: user, post: post)
    expect(like).to be_valid
  end

  it 'increments the post likes_counter after creation' do
    expect { Like.create(author: user, post: post) }
      .to change { post.reload.likes_counter }.by(1)
  end
end
