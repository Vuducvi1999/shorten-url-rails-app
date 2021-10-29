class CreateShortenUrl < ActiveRecord::Migration[6.1]
  def change
    create_table :shorten_urls do |t|
      t.string :origin
      t.string :alias
      t.integer :clicked
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
    add_index :shorten_urls, :alias, unique: true
  end
end
