



Rails.application.routes.draw do

  devise_for :users
  mount Ckeditor::Engine => '/ckeditor'
  get 'welcome/index'

resources :articles do
resources :comments


end





  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
