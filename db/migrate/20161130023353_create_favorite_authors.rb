class CreateFavoriteAuthors < ActiveRecord::Migration[5.0]
  def change
    create_table :favorite_authors do |t|
      t.references :author, foreign_key: true
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
