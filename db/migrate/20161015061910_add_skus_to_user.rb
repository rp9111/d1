class AddSkusToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :sku_ids, :text
  end
end
