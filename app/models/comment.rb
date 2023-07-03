class Comment < ApplicationRecord
  validates :user, :body, presence: true
  belongs_to :article
end
