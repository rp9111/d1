class CreateSubscriptions < ActiveRecord::Migration[5.0]
  def change
    create_table :subscriptions do |t|
      t.references :user, foreign_key: true
      t.references :area, foreign_key: true
      t.datetime :expires_at

      t.timestamps
    end
  end
end
