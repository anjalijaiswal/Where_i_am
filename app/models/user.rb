class User < ActiveRecord::Base
	has_many :friendships
	has_many :friends, :through => :friendships
	has_many :inverse_friendships, :class_name => "Friendship", :foreign_key => "friend_id"
	has_many :inverse_friends, :through => :inverse_friendships, :source => :user
	has_many :locations
end


#http://localhost:3000/friendships/get_friends.json?
#http://localhost:3000/friendships/add_friend.json? {"friend_id":2}
#http://localhost:3000/users/registration.json? {"username":"bijuv", "password":"1234567"....}
#http://localhost:3000/users/login.json? {"username":"bijuv", "password":"1234567"}
#http://localhost:3000/users/logout.json?
