class FriendshipsController < ApplicationController

	def get_friends
		@friendship = User.first.friends
	end
end
