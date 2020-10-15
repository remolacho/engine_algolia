class Product < ApplicationRecord
  include AlgoliaSearch

  has_many :category_products, dependent: :delete_all
  has_many :categories, through: :category_products

  accepts_nested_attributes_for :categories

  algoliasearch per_environment: true do
    attribute :id
    attribute :title
    attribute :description
    attribute :is_deleted
    attribute :active
    attribute :created_at
    attribute :category_ids
    attribute :price
    attribute :categories do
      categories.map(&:name)
    end

    tags do
      [categories.map(&:name), "active_#{active}", "product_#{id}", "is_deleted_#{is_deleted}"]
    end

    attributesToHighlight ['title', 'description', 'categories']
    highlightPreTag '<strong>'
    highlightPostTag '</strong>'
    searchableAttributes ['title', 'description', 'categories']
    attributesForFaceting ['searchable(categories)', 'price']
    hitsPerPage 10
    paginationLimitedTo 5000
  end

end
