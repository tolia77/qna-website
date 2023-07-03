class Answer < ApplicationRecord
  after_initialize do
    self.accepted = false if new_record?
  end
  belongs_to :user
  belongs_to :question
  validates :question_id, uniqueness: { scope: :user_id, message: 'You have already answered this question' }
end
