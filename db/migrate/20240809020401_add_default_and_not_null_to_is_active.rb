class AddDefaultAndNotNullToIsActive < ActiveRecord::Migration[6.1]
  def change
   change_column_default :users, :is_active, from: nil, to: true
   User.where(is_active: nil).update_all(is_active: true)
   change_column_null :users, :is_active, false
  end
end
