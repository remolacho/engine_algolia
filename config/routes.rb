Rails.application.routes.draw do
  match 'products/index', via: [:get, :post]

  resources :products, except: [:index] do
    collection do
      get :searches
      get :searches_categories
    end
  end

end
