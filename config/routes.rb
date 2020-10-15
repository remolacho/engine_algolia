Rails.application.routes.draw do
  match 'products/index', via: [:get, :post]
end
