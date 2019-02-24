class AddUserIdInCatagory < ActiveRecord::Migration[5.2]
  def change
  	add_column :catagories, :user_id, :integer
  end
end
