class CreateShortenUrls < ActiveRecord::Migration[6.1]
  def change
    create_table :shorten_urls do |t|
      t.string :origin
      t.string :link
      t.integer :clicked
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
