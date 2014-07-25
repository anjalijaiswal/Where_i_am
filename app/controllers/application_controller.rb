class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  skip_before_filter  :verify_authenticity_token
  helper_method :current_user

  private
  	def current_user
   		access_token = ApiKey.where(:access_token => request.headers["token"]).first rescue nil
    	if !access_token.blank?
       		@current_user ||= access_token.user
    	else
      		render json: {:message => "Login Required"}
     		return false
   		end
  	end
end
