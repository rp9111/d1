class CreateImpressions < ActiveRecord::Migration[5.0]
  def change
    create_table :impressions do |t|
      t.string      :ip
      t.references  :impressionable, polymorphic: true
      t.integer     :user_id
      t.string      :ip_country,          limit: 255
      t.string      :ip_region,           limit: 255
      t.string      :ip_zip,              limit: 255
      t.string      :ip_latitude,         limit: 255
      t.string      :ip_longitude,        limit: 255
      t.integer     :hits,                default: 0

      t.timestamps
    end
    add_index :impressions, :ip
  end
end
