class Post < ApplicationRecord
  belongs_to :group, optional: true
  belongs_to :user
  has_many :used_tags, as: :tagged, dependent: :destroy
  has_many :votes, as: :voted, dependent: :destroy
  has_many :comments, as: :commentable, dependent: :destroy
  enum post_type: {post: 1, question: 2}
  enum visibility: {everyone: 1, just_me: 2}
end
