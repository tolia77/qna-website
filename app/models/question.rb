class Question < ApplicationRecord
  has_many :answers, dependent: :destroy
  belongs_to :category
  belongs_to :user

  validates :title, presence: true, length: { minimum: 10, maximum: 50}
  validates :content, presence: true, length: { minimum: 30, maximum: 5000}
end
