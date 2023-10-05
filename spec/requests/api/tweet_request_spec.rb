require 'rails_helper'

RSpec.describe "API Tweets", type: :request do
  let(:response_body) { JSON.parse(response.body) }

  describe "#index" do
    context 'When there are tweets' do
      let!(:tweet_list) { create_list(:tweet, 2)}

      before do
        create_list(:tweet, 5)
      end

      it 'returns a successful response' do
        get api_tweets_path

        expect(response).to have_http_status(:success)
      end
    end
  end

  describe "#create" do
    context 'with valid parameters' do
      let(:user1) { create(:user)}
      let(:valid_body) { 'This is a valid tweet' }

      it 'returns a successful response' do
        post api_tweets_path(user_id: user1.id, body: valid_body)

        expect(response).to have_http_status(:success)
      end

      it 'creates a new tweet' do
        expect {
          post api_tweets_path(user_id: user1.id, body: valid_body)
        }.to change(Tweet, :count).by(1)
      end
    end

    xcontext 'With invalid parameters' do
      let(:user1) { create(:user)}

      context 'When the body is invalid' do
        let(:invalid_body) { '' }

        it 'returns an error response' do
          post api_tweets_path(user_id: user1.id, body: invalid_body)

          expect(response).to have_http_status(:unprocessable_entity)
        end

        it 'does not create a new tweet' do
          expect {
            post api_tweets_path(user_id: user1.id, body: invalid_body)
          }.to_not change(Tweet, :count)
        end
      end

      xcontext 'When the tweet is invalid' do
        let(:body) { 'This is a valid tweet' }
        let!(:tweet1) { create(:tweet, user: user1, body: body) }

        it 'returns an error response' do
          post api_tweets_path(user_id: user1.id, body: body)

          expect(response).to have_http_status(:unprocessable_entity)
        end

        it 'does not create a new tweet' do
          expect {
            post api_tweets_path(user_id: user1.id, body: body)
          }.to_not change(Tweet, :count)
        end
      end
    end
  end
end
