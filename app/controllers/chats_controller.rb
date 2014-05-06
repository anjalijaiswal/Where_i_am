class ChatsController < ApplicationController
  def chatting
  	@chats = Chat.all#(:order => "created_at DESC")
    respond_to do |format|
      format.html
    end
  end
  
  def create
    @chat = Chat.create(:message => params[:message], created_at: Time.now)
    respond_to do |format|
      if @chat.save
        format.html { redirect_to chats_chatting_path }
        format.js
      else
        flash[:notice] = "Message failed to save."
        format.html { redirect_to chats_chatting_path }
      end
    end
  end
end
