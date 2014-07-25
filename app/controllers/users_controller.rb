class UsersController < ApplicationController
	
    	def registration
           @newuser =User.new(:first_name=>params[:first_name], :last_name=>params[:last_name], :username=>params[:username], :password=>params[:password], :email=>params[:email], phone_number:params[:phone_number], address:params[:address])
           if @newuser.save!
           	 @result="User created successfully"
           else
             @result="Error" 
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
    ApiKey.where(:user_id=>params[:user_id]).first.destroy
    # if current_user.present?
    #   @status = current_user.api_key.destroy if current_user.api_key.access_token == request.headers["token"] 
    # end
  end

  def fetch_contacts
     puts "===============#{params}"

    @api_key=ApiKey.find_by_access_token(params[:api_key])
    @user=@api_key.user
    puts ".................................#{@user.username}"
    @contact = @user.contacts.create(params[:name],params[:number])
   
  end

end
