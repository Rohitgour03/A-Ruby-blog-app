json.extract! article, :id, :title, :body, :author, :publisheda_at, :created_at, :updated_at
json.url article_url(article, format: :json)