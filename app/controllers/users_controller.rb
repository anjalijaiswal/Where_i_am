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
    @user = User.authenticate(params[:username], params[:password])
    if @user.blank?
      render json: {:message => "Invalid Login", :response_code => 1101} unless params[:username].nil?
      #render json: {:message => "Invalid Login", :response_code => 1100} unless params[:password].nil?
    elsif @user.api_key.present?
      render json: {:message => "Already Signed In", :response_code => 0111}
      return false             
    else
        @user.create_api_key
        @result = @user.api_key.access_token
    end  
    end

  def logout
    ApiKey.destroy_all
    # if current_user.present?
    #   @status = current_user.api_key.destroy if current_user.api_key.access_token == request.headers["token"] 
    # end
  end

end
