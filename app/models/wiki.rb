class Wiki < ActiveRecord::Base
  belongs_to :user
  has_many :collaborators
  has_many :users, through: :collaborators

  default_scope { order('created_at DESC') }

  validates :title, length: { minimum: 3 }, presence: true
  validates :body, length: { minimum: 20 }, presence: true
  validates :user, presence: true
end
