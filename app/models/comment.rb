class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :answer
  validates :text, presence: true, length: {maximum: 300}
end
