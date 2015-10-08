class Comment < ActiveRecord::Base
  belongs_to :entry
  default_scope -> { order(created_at: :desc) }
  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: 150 }
end
