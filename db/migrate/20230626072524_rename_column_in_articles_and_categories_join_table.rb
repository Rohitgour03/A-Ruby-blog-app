class RenameColumnInArticlesAndCategoriesJoinTable < ActiveRecord::Migration[7.0]
  def change
    rename_column :articles_categories, :articles_id, :article_id
    rename_column :articles_categories, :categories_id, :category_id
  end
end
