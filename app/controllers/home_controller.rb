class HomeController < ApplicationController
  def index
    @tweets = Tweet.includes(:user).order("created_at DESC").limit(20)
  end
end
