class Chat
  include Mongoid::Document
  field :user_id, type: Integer
  field :message, type: String
  field :type, type: String
  field :created_at, type: Time
  field :friend_id, type: Integer
  #embedded_in :user
  # index :user_id, :unique => true
  def user
	User.find_by_id(user_id)
  end
end


#http://britg.com/2012/01/07/forging-forgecraft-a-hybrid-sql-mongodb-data-solution/