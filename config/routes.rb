Rails.application.routes.draw do
  root 'welcome#index'

  # Creating a new entry is bound to subjects, so the overview page should not allow creating new entries.

  resources :posts, except: [:new, :create]

  resources :journals, except: [:new, :create]

  resources :tasks, except: [:new, :create] do
    resources :task_items, only: [:create, :update, :delete]
    resources :task_comments, only: [:create, :update, :delete]
  end

  resources :subjects do
    resources :posts, only: [:index, :new, :create]
    resources :journals, only: [:index, :create]
    resources :tasks, only: [:index, :new, :create]
  end

  resources :categories
end
