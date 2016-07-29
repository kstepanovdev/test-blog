class FixPasswordConfiramatiomColumn < ActiveRecord::Migration[5.0]
  def change
    rename_column :users, :password_confiramation, :password_confirmation
  end
end
