class Post < ApplicationRecord
  belongs_to :user
  has_many :comments
  has_many :point

  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: 140 }
  validates :url, presence: true, length: { maximum: 255 }
end
