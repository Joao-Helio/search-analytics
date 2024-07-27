class AddTsvContentTrigger < ActiveRecord::Migration[7.1]
  def up
    execute <<-SQL
      CREATE OR REPLACE FUNCTION update_article_tsv_content()
      RETURNS trigger AS $$
      BEGIN
        NEW.tsv_content := setweight(to_tsvector('english', coalesce(NEW.title, '')), 'A') ||
                           setweight(to_tsvector('english', coalesce(NEW.content, '')), 'B') ||
                           setweight(to_tsvector('english', coalesce(NEW.author, '')), 'C');
        RETURN NEW;
      END
      $$ LANGUAGE plpgsql;

      CREATE TRIGGER article_tsv_content_trigger
      BEFORE INSERT OR UPDATE ON articles
      FOR EACH ROW
      EXECUTE FUNCTION update_article_tsv_content();
    SQL
  end

  def down
    execute <<-SQL
      DROP TRIGGER IF EXISTS article_tsv_content_trigger ON articles;
      DROP FUNCTION IF EXISTS update_article_tsv_content();
    SQL
  end
end
