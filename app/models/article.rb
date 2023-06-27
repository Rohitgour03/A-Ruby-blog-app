class Article < ApplicationRecord
    validates :title, :body, :author, :published_at, presence: true

    has_many :comments
    has_and_belongs_to_many :categories
    has_and_belongs_to_many :tags
end
