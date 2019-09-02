class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_one :profile
  has_many :chatroom_users
	has_many :chatrooms, through: :chatroom_users
	has_many :messages
	has_many :requests
	
  
  validates_email_realness_of :email

end