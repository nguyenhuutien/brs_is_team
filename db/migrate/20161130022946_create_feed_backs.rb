class CreateFeedBacks < ActiveRecord::Migration[5.0]
  def change
    create_table :feed_backs do |t|
      t.string :name
      t.string :email
      t.string :phone
      t.string :message

      t.timestamps
    end
  end
end
