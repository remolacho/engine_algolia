class Category < ApplicationRecord
  has_many :category_products, dependent: :delete_all
  has_many :products, through: :category_products

  after_commit :reindex_products

  def reindex_products
    products.each(&:index!)
  end
end
