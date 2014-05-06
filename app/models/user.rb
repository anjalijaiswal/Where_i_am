class User < ActiveRecord::Base
	has_many :friendships
	has_many :friends, :through => :friendships
	has_many :inverse_friendships, :class_name => "Friendship", :foreign_key => "friend_id"
	has_many :inverse_friends, :through => :inverse_friendships, :source => :user
	has_one :api_key, dependent: :destroy
	#has_many :chats
	# implemented scope for the understanding purpose.
	scope :pass, -> { where(password: 1234567) }
	scope :other_friends_only, -> { joins(:friends)}

	def self.authenticate(username="", password="")
        user = User.where("username = ? && password = ?", username, password).take
     	if user.present? 
        	return user
        else
        	return false
        end
  	end

  	def chats
		@chats ||= (Chat.where(:user_id => self.id))
	end

	def create_chats message, friend_id
		if message.present? && friend_id.present?
			@chat = Chat.create(user_id: self.id, message: message, friend_id: friend_id, created_at: Time.now)
		else
			raise "Should have message/friend_id"
		end
	end

end



#http://localhost:3000/friendships/get_friends.json?
#http://localhost:3000/friendships/add_friend.json? {"friend_id":2}
#http://localhost:3000/users/registration.json? {"username":"bijuv", "password":"1234567"....}
#http://localhost:3000/users/login.json? {"username":"bijuv", "password":"1234567"}
#http://localhost:3000/users/logout.json?