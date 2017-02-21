class AddMessageToPromos < ActiveRecord::Migration[5.0]
  def change
    add_column :promos, :message, :text, default: ''
    add_column :users, :promo, :string
  end
end
