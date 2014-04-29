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
end
