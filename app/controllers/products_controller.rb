class ProductsController < ApplicationController
  def index
    @term = params[:search]
    @products = if params[:category].present?
                  by_category
                elsif params[:product_id].present?
                  similars
                elsif params[:range_price].present?
                  by_range_price
                else
                  products
                end

    @categories = group_categories
    @range_prices = group_price
  end

  private

  def group_categories
    return [] unless @products.present?

    @products.facets['categories'].map { |name, count|
      { name: name, count: count }
    }
  end

  def group_price
    return [] unless @products.present?
    init = 0
    @products.facets['price'].keys.map(&:to_i).sort.each_slice(2).to_a.map do |price|
      arr =  [init, price.last]
      init = price.last
      arr.join(' - ')
    end
  end

  def products
    Product.includes(:categories)
        .order(:created_at, :desc)
        .search(@term,
                tagFilters: %w[is_deleted_false active_true],
                page: params[:page] || 1,
                facets: %w[categories price])
  end

  def by_category
    Product.includes(:categories)
           .order(:created_at, :desc)
           .search('*',
                   tagFilters: [params[:category], 'is_deleted_false', 'active_true'],
                   page: params[:page] || 1,
                   facets: %w[categories price])
  end

  def similars
    product = Product.find(params[:product_id])
    Product.includes(:categories)
           .order(:created_at, :desc)
           .search('', similarQuery: product.title,
                       tagFilters: %w[is_deleted_false active_true],
                       page: params[:page] || 1,
                       facets: %w[categories price])
  end

  def by_range_price
    price_str = params[:range_price].gsub('-', 'TO')
    price_to = "price:#{price_str}"
    Product.includes(:categories)
        .order(:created_at, :desc)
        .search('*',
                filters: price_to,
                tagFilters: %w[is_deleted_false active_true],
                page: params[:page] || 1,
                facets: %w[categories price])
  end

end
