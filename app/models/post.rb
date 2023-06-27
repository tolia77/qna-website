class Post < ApplicationRecord
  belongs_to :user
  validates :title, presence: true
  validates :content, presence: true, length: { minimum: 50, maximum: 30000}
end
