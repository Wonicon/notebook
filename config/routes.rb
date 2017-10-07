Rails.application.routes.draw do
  root 'welcome#index'

  # Creating a new entry is bound to subjects, so the overview page should not allow creating new entries.

  resources :posts, only: [:index, :show, :edit]

  resources :journals, only: [:index, :show, :edit]

  resources :tasks, only: [:index, :show, :edit] do
    resources :task_items
  end

  resources :subjects do
    resources :posts, only: [:index, :new, :create]
    resources :journals, only: [:index, :new, :create]
    resources :tasks, only: [:index, :new, :create]
  end

  resources :categories
end
