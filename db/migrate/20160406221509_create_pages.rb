class CreatePages < ActiveRecord::Migration[5.0]
  def change
    create_table :pages do |t|
      t.string :title
      t.text :content
      t.string :cover
      t.string :permalink
      t.references :area, foreign_key: true
      t.boolean :commentable, default: false
      t.hstore :properties
      t.integer :position
      t.references :user, foreign_key: true
      t.boolean :publish, default: true
      t.integer :impressions_count, default: 0
      t.datetime :published_at
      t.datetime :pull_at

      t.timestamps
    end
  end
end
