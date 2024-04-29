class ChatRoom < ApplicationRecord
  has_many :participants
  has_many :users, through: :participants
  has_many :messages
  validates :name, presence: true, uniqueness: true
  validates :description, presence: true
end
