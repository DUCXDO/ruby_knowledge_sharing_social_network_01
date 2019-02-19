class User < ApplicationRecord
  has_one :profile, dependent: :destroy
  has_many :active_relationships, class_name: Relationship.name,
    foreign_key: "follower_id", dependent: :destroy
  has_many :passive_relationships, class_name: Relationship.name,
    foreign_key: "followed_id", dependent: :destroy
  has_many :following, through: :active_relationships, source: :followed
  has_many :followers, through: :passive_relationships, source: :follower
  has_many :group_admins
  has_many :votes
  has_many :used_tags, as: :tagged, dependent: :destroy
  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
end