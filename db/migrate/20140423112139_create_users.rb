class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.string :username
      t.string :password
      t.string :email
      t.string :phone_number
      t.string :address
      t.string :display_picture
      t.timestamps
    end
  end
end
