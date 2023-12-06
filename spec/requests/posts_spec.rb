require 'rails_helper'

RSpec.describe 'Posts', type: :request do
  let(:valid_attributes) do
    {
      name: 'Wood'
    }
  end

  describe 'GET /posts' do
    before :each do
      @user = User.create! valid_attributes
      get user_posts_path(@user)
    end

    it 'returns a successful response' do
      expect(response).to be_successful
    end

    it 'renders the correct template' do
      expect(response).to render_template(:index)
    end

    it 'includes correct placeholder text in the response body' do
      expect(response.body).to include('Here is List of Post for all users')
    end
  end

  describe 'GET /posts/:id' do
    before :each do
      @user = User.create! valid_attributes
      @post = @user.posts.create(title: 'First post')
      get user_post_path(@user, @post)
    end

    it 'returns a successful response' do
      expect(response).to be_successful
    end

    it 'renders the correct template' do
      expect(response).to render_template(:show)
    end

    it 'includes correct placeholder text in the response body' do
      expect(response.body).to include('Here is Sppecic Post')
    end
  end
end