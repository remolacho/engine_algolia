class CategoryProduct < ApplicationRecord
  belongs_to :category
  belongs_to :product

  after_commit :reindex_products

  private

  def reindex_products
    prod_index = Product.find(product_id)
    prod_index.index!
  end
end
