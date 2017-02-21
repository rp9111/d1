class CreateComments < ActiveRecord::Migration[5.0]
  def change
    create_table :comments do |t|
      t.references :user, foreign_key: true
      t.references :page, foreign_key: true
      t.integer :parent_id, index: true
      t.text :content
      t.datetime :submitted_at
      t.boolean :approved
      t.datetime :posted_at

      t.timestamps
    end
  end
end
