class CreateArticles < ActiveRecord::Migration[7.1]
  def change
    create_table :articles do |t|
      t.string :author
      t.string :claps
      t.integer :reading_time
      t.string :link
      t.string :title
      t.text :content
      t.tsvector :tsv_content, null: true

      t.timestamps
    end
  end
end
