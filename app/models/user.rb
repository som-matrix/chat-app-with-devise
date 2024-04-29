class User < ApplicationRecord
  has_many :participants
  has_many :chat_rooms, through: :participants
  has_many :messages
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :timeoutable
  has_one_attached :avatar do |attachable|
    attachable.variant :thumb, resize_to_limit: [100, 100]
  end
end
