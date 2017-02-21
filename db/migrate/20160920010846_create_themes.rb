class CreateThemes < ActiveRecord::Migration[5.0]
  def change
    create_table :themes do |t|
      t.string :name
      t.text :structure
      t.text :style
      t.text :behavior

      t.timestamps
    end
  end
end
