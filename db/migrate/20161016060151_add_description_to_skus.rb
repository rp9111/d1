class AddDescriptionToSkus < ActiveRecord::Migration[5.0]
  def change
    add_column :skus, :description, :text
  end
end
