class Chatroom < ApplicationRecord
	has_many :chatroom_users
	has_many :users, through: :chatroom_users
	has_many :messages
	has_many :requests


    validates :title, presence: true
    
    searchable do
        text :details
        text :title
    end
end