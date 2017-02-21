class CreateAreas < ActiveRecord::Migration[5.0]
  def change
    create_table :areas do |t|
      t.string :name
      t.string :label
      t.boolean :navigation, default: true
      t.boolean :footer, default: false
      t.boolean :comments, default: false
      t.boolean :paid, default: true
      t.boolean :restricted, default: false
      t.integer :position
      t.integer :theme_id
      t.boolean :ascending
      t.hstore  :properties
      t.string :mode

      t.timestamps
    end
  end
end
