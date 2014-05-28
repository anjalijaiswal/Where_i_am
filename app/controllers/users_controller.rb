class UsersController < ApplicationController
	
    	def registration
           @newuser =User.new(:first_name=>params[:first_name], :last_name=>params[:last_name], :username=>params[:username], :password=>params[:password], :email=>params[:email], phone_number:params[:phone_number], address:params[:address])
           if @newuser.save!
           	 @result="User created successfully"
           else
             @result="Error" 
           end
      end

    	def login
    		@authenticate_user=User.find_by_username_and_password(params[:username],params[:password])
    		     if @authenticate_user.present?
    		      	@result="login successfully"
             else
                @result="login unsuccessfully"
             end 
    	end

      def set_location
        @current_user = User.find(params[:id])
        @current_user.locations.build(longitude:params[:longitude], latitude:params[:latitude])
        @current_user.save
      end

      def get_location
        @current_user = User.find(params[:id])
        @my_location = @current_user.locations.last
        @friends_location = @current_user.friends.map{|e|h={name:e.first_name, locations:e.locations.last}} 
      end
    
end 
                                                         