# frozen_string_literal: true

# == Schema Information
#
# Table name: users
#
#  id                   :integer          not null, primary key
#  username             :string           not null
#  email                :string           not null
#  password_digest      :string           not null
#  confirmation_token   :string
#  confirmation_sent_at :datetime
#  is_active            :boolean          default(FALSE)
#  is_admin             :boolean          default(FALSE)
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#
class User < ApplicationRecord
  has_secure_password

  has_many :likes, dependent: :destroy
  has_many :posts, dependent: :destroy

  has_many :liked_posts, through: :likes, source: :likeable, source_type: 'Post'
  has_many :liked_comments, through: :likes, source: :likeable, source_type: 'Comment'

  validates :username, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true
  validates :password, presence: true, on: :create

  before_create :generate_confirmation_token

  def generate_confirmation_token
    self.confirmation_token = SecureRandom.urlsafe_base64
    self.confirmation_sent_at = Time.current.utc
  end

  def confirmation_token_valid?
    confirmation_sent_at > 1.hour.ago.utc
  end

  def confirm!
    update!(confirmation_token: nil, is_active: true)
  end

  # calling liked_posts forcibly calls posts has_many and therefore looks at post_id which is wrong
  def fetch_liked_posts
    Post.joins(:likes)
        .where(likes: { user_id: id, likeable_type: 'Post' })
        .distinct
  end
end
