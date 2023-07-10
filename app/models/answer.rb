class Answer < ApplicationRecord
  after_initialize do
    self.accepted = false if new_record?
  end
  has_many :comments, dependent: :destroy
  belongs_to :user
  belongs_to :question
  validates :question_id, uniqueness: { scope: :user_id, message: 'You have already answered this question' }
  validates :text, presence: true, length: { minimum: 5, maximum: 5000 }
end
