class AddAccountCurrentToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :account_current, :boolean
    add_column :users, :plan_id, :string
    add_column :users, :stripe_id, :string
    add_column :users, :active_until, :datetime
  end
end
