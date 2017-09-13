Rails.application.routes.draw do

  match "/lower_all_payables" => "account_payables#lower_all_payables", via: [:get]
  match "/sub_cost_centers_by_cost", :controller => "cost_centers", :action => "sub_cost_centers_by_cost", via: [:get]
  match "/sub_cost_centers_three_by_sub_cost_center", :controller => "sub_cost_centers", :action => "sub_cost_centers_three_by_sub_cost_center", via: [:get]

  resources :lower_payables, only: [:destroy]
  resources :lower_receivables, only: [:destroy]

  resources :account_payables do
    member do
      get 'lower'
      post 'pay'
    end
    collection do
      get 'search'
      get 'post'
      post 'pay_all'
    end
  end

  resources :account_receivables do
    member do
      get 'lower'
      post 'pay'
    end
  end

  resources :people
  resources :current_accounts
  resources :sub_cost_center_threes
  resources :sub_cost_centers
  resources :cost_centers
  resources :account_banks

  devise_for :users

  root to: 'current_accounts#index'
end  

