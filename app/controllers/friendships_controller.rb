class FriendshipsController < ApplicationController

	def get_friends
		@friendship = User.first.friends
	end

	
	def add_friend
       @friend = User.first.friendships.build(friend_id:params[:friend_id])
        if @friend.save!
        	@result= "added"
        else	
        	@result= " not added"
        end 	 
   end

end
