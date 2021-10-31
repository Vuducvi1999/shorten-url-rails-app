class ChangeUsersAccessKey < ActiveRecord::Migration[6.1]
  def change
    rename_column :users, :access_key, :access_api
  end
end
