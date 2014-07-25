class FriendshipsController < ApplicationController

	def get_friends
		@friendship = current_user.friends
	end

	def add_friend
    if current_user.id == params[:friend_id] && current_user.present?
      render json: {:message => "Invalid Entry"}
    else
      @already_friend=Friendship.where(user_id:current_user.id,friend_id:params[:friend_id])
      if @already_friend.present?
        render json: {:message => "You are already his/her friend", :response_code => 0111}
      else
        @friend = current_user.friendships.build(friend_id:params[:friend_id])
          if @friend.save!
            render json: {:message => "Friend added successfully"}
          else	
         	@result= " not added"
          render json: {:message => "Caught with an error :("}
          end 	 
       end
     end
   end
end
