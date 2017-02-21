class CreateOauthids < ActiveRecord::Migration[5.0]
  def change
    create_table :oauthids do |t|
      t.string :provider
      t.string :uid
      t.string :token
      t.string :secret
      t.string :image_url
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
