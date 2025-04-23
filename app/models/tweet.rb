# == Schema Information
#
# Table name: tweets
#
#  id         :integer          not null, primary key
#  body       :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :integer
#
# Foreign Keys
#
#  user_id  (user_id => users.id)
#
class Tweet < ApplicationRecord
  belongs_to :user

  validates :body, length: { maximum: 180, allow_blank: true }
  validate :avoid_duplicated_body_same_day, if: proc { self.body }

  scope :not_in_company, -> { joins(:user).where(company_id: nil) }

  def avoid_duplicated_body_same_day
    same_body_tweet = user.tweets.where(body: self.body).first

    return true if some_body_tweet.blank?

    same_body_created_at = same_body_tweet.created_at

    errors.add(:avoid_duplicated_body_same_day, 'not allowed same body within 24 hours') if same_body_created_at < 1.day.ago
  end
end
