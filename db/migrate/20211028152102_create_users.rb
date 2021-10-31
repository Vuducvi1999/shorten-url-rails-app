class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :password_digest
      t.string :access_key

      t.timestamps
    end
    add_index :users, :email, unique: true
    add_index :users, :access_key, unique: true
  end
end
