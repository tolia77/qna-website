class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_many :posts
  has_many :questions, dependent: :destroy
  has_many :answers, dependent: :destroy
  has_many :comments, dependent: :destroy
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  enum role: %w(user admin)
  after_initialize :set_default_role, :if => :new_record?
  validates :name, presence: true, length: { maximum: 16 }
  def set_default_role
    self.role ||= :user
  end

end
