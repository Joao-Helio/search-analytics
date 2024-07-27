require 'csv'

Article.delete_all

CSV.foreach(Rails.root.join('db/articles.csv'), headers: true) do |row|
  Article.create!(
    author: row['author'],
    claps: row['claps'],
    reading_time: row['reading_time'].to_i,
    link: row['link'],
    title: row['title'],
    content: row['content']
  )
end
