class AddSkusToArea < ActiveRecord::Migration[5.0]
  def change
    add_column :areas, :sku_ids, :text
  end
end
