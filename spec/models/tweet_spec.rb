require 'rails_helper'

RSpec.describe Tweet, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"

  context 'validation' do
    it 'should have 180 caracters in body content' do
      tweet = Tweet.new(body: '12345')

      tweet.valid?
      expect(tweet.errors).to have_key(:length)
    end

    it 'should have 180 caracters in body content' do
      tweet = Tweet.new(body: '12345') # put more that 180 caracters to check this test

      tweet.valid?
      expect(tweet.errors).to_not have_key(:length)
    end
  end
end
