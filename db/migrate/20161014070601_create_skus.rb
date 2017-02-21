class CreateSkus < ActiveRecord::Migration[5.0]
  def change
    create_table :skus do |t|
      t.string :name
      t.string :plan_id
      t.integer :amount, default: 0
      t.string :interval

      t.timestamps
    end
  end
end
