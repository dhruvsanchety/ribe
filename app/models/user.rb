class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :uid, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :uid
         
  has_one :profile
  has_many :chatroom_users
	has_many :chatrooms, through: :chatroom_users
	has_many :messages
	has_many :requests
	
  
  def to_param  # overridden
    uid
  end
  
  validates_email_realness_of :email

end