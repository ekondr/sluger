class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.string :title,    limit: 150,   null: false
      t.string :slug,     limit: 150,   null: false

      t.timestamps null: false
    end

    add_index :articles, :slug, unique: true
  end
end
