class Issue < ApplicationRecord
  belongs_to :user
  validates :category, presence: true
  validates :description, presence: true, length: { minimum: 16, maximum: 2000 }
end
