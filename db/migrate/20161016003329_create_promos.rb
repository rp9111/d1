class CreatePromos < ActiveRecord::Migration[5.0]
  def change
    create_table :promos do |t|
      t.string :name
      t.integer :course_id
      t.string :stripe_coupon
      t.integer :hits, default: 0
      t.integer :conversions, default: 0
      t.boolean :enabled
      t.datetime :expires_on

      t.timestamps
    end
  end
end
