class FriendshipsController < ApplicationController

	def get_friends
		@friendship = User.first.friends
	end

	
	def add_friend
       @friend = User.first.friendships.build(friend_id:params[:friend_id])
        if @friend.save!
        	@result= "added"
        else	
        	@result= "we both r not friend of own"
        end 	 
   end

end
