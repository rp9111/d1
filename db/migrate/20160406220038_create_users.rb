class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.string :user_name
      t.string :email
      t.string :password_digest
      t.references :group, foreign_key: true
      t.string :avatar
      t.string :status
      t.boolean :confirmed
      t.boolean :admin
      t.string :token
      t.string :reset_token
      t.string :stripe_token
      t.datetime :reset_at
      t.text :bio
      t.hstore :preferences

      t.timestamps
    end
  end
end
