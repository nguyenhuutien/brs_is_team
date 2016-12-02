class CreateIdentities < ActiveRecord::Migration[5.0]
  def change
    create_table :identities do |t|
      t.references :user, foreign_key: true
      t.string :provider
      t.string :uid
      t.string :access_token
      t.string :refresh_token
      t.string :email
      t.string :image
      t.string :name      

      t.timestamps
    end
  end
end
