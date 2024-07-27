class UpdateTsvContentForExistingArticles < ActiveRecord::Migration[7.1]
  def up
    execute <<-SQL
      UPDATE articles
      SET tsv_content = setweight(to_tsvector('english', coalesce(title, '')), 'A') ||
                        setweight(to_tsvector('english', coalesce(content, '')), 'B') ||
                        setweight(to_tsvector('english', coalesce(author, '')), 'C');
    SQL
  end

  def down
    execute <<-SQL
      UPDATE articles
      SET tsv_content = NULL;
    SQL
  end
end
