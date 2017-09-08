Rails.application.routes.draw do

  match "/sub_cost_centers_by_cost", :controller => "cost_centers", :action => "sub_cost_centers_by_cost", via: [:get]
  match "/sub_cost_centers_three_by_sub_cost_center", :controller => "sub_cost_centers", :action => "sub_cost_centers_three_by_sub_cost_center", via: [:get]

  resources :account_payables
  resources :people
  resources :current_accounts
  resources :sub_cost_center_threes
  resources :sub_cost_centers
  resources :cost_centers
  resources :account_banks

  devise_for :users

  root to: 'current_accounts#index'
end  

