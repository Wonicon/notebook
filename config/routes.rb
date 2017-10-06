Rails.application.routes.draw do
  get 'welcome/index'

  root 'welcome#index'

  # Creating a new entry is bound to subjects, so the overview page should not allow creating new entries.

  resources :posts, only: [:index, :show, :edit]

  resources :journals, only: [:index, :show, :edit]

  resources :tasks, only: [:index, :show, :edit]

  resources :subjects do
    resources :posts
    resources :journals
    resources :tasks do
      resources :task_items
    end
  end

  resources :categories
end
