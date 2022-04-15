class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :movie, optional: true, primary_key: "id"
  default_scope -> { order(created_at: :desc) }
  validates :user_id,   presence: true
  validates :movie_id,  presence: true
  validates :content,   presence: true, length: { maximum: 250}
end
