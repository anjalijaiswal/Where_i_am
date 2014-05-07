class ChatsController < ApplicationController
  def chatting
    @me = User.find(session[:current_user_id]) if session[:current_user_id].present?
  	@chats = Chat.where(user_id:session[:current_user_id])
    @friends_chat = Chat.where(friend_id:session[:current_user_id])
    respond_to do |format|
      format.html
    end
  end
  
  def create
    @user = User.find(session[:current_user_id])
    @chat = Chat.create(user_id:session[:current_user_id],:message => params[:message], :friend_id => params[:friend_id], created_at: Time.now) if @user.friends.ids.include?(params[:friend_id].to_i) || @user.inverse_friends.ids.include?(params[:friend_id].to_i)
    respond_to do |format|
      if @chat.present? && @chat.save
        format.html { redirect_to chats_chatting_path }
        format.js
      else
        flash[:notice] = "Message failed to post"
        format.html { redirect_to chats_chatting_path }
      end
    end
  end
end


