class Category < ApplicationRecord
  has_many :questions, dependent: :destroy
  has_one_attached :image
  validates :name, presence: true, uniqueness: true
end
