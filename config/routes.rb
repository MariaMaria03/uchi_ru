Rails.application.routes.draw do

  get '/', to: 'home#index'
  root to: 'home#index'

  get 'active_users_repos' => 'contributors#active_contributors', as: :active_contributors
  get 'download_pdf' => 'contributors#download_pdf', as: :download_pdf
  get 'download_zip' => 'contributors#download_zip', as: :download_zip
end
