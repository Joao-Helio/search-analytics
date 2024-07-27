class Article < ApplicationRecord
    def self.search(query)
        return Article.none if query.blank?
    
        where("tsv_content @@ plainto_tsquery('english', ?)", query)
    end
end
  