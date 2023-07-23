Rails.application.routes.draw do
# MAIN
  root "main#index"
  
  # DASHBOARD
  get "dashboard", to: "dashboards#index", as: :dashboard
  get "dashboard/getting-started", to: "main#confluence", as: :confluence
  
  # PAGES
  get "/coming-soon", to: "main#comingsoon", as: :comingsoon
  get "about", to: "main#about", as: :about
    # CONTACT
    get "about/contact", to: "main#contact_us", as: :contact_us
    get "about/contact-leash", to: "main#contact_leash", as: :contact_leash
    get "send_contact", to: "main#contact", as: :contact
    post "send_contact", to: "main#send_contact", as: :send_contact
    get "contact2", to: "main#contact", as: :contact_2
  
    # PRIVACY POLICY
    get "privacy-policy", to: "main#privacy_policy", as: :privacy_policy
    get "privacy-policy/cookies", to: "main#cookies_policy", as: :cookies
    get "privacy-policy/data_request", to: "main#contact_leash", as: :data_request
  
    # TERMS OF SERVICE
    get "terms-of-service", to: "main#terms_service", as: :terms_service
    get "terms-of-service/acceptable-use", to: "main#acceptable_use", as: :acceptable_use
    get "terms-of-service/accessibility", to: "main#accessibility", as: :accessibility
    get "terms-of-service/eula", to: "main#eula", as: :eula

# CLIENTS
  get "clients/admin", to: "clients#index", as: :manage_clients
  get "clients/new", to: "clients#new", as: :new_client
  post "clients/new", to: "clients#create"
  get "clients/:id", to: "clients#show", as: :client
  get "clients/:id/edit", to: "clients#edit", as: :edit_client
  post "clients/edit", to: "clients#update"
  patch "clients/:id", to: "clients#update"

# PETS
  get "pets/admin", to: "pets#index", as: :manage_pets
  get "pets/new", to: "pets#new", as: :new_pet
  post "pets/new", to: "pets#create"
  get "pets/:id", to: "pets#show", as: :pet
  get "pets/:id/edit", to: "pets#edit", as: :edit_pet
  post "pets/edit", to: "pets#update"
  patch "pets/:id", to: "pets#update"

# WALKS
  get "walks/admin", to: "walks#index", as: :manage_walks
  get "walks/new", to: "walks#new", as: :new_walk
  post "walks/new", to: "walks#create"
  get "walks/:id", to: "walks#show", as: :walk
  get "walks/:id/edit", to: "walks#edit", as: :edit_walk
  post "walks/edit", to: "walks#update"
  patch "walks/:id", to: "walks#update"

# REPORTS
  get "reports/admin", to: "reports#index", as: :reports
  get "reports/new", to: "reports#new", as: :new_report
  post "reports/new", to: "reports#create"
  get "reports/:id", to: "reports#show", as: :report
  get "reports/:id/edit", to: "reports#edit", as: :edit_report
  post "reports/edit", to: "reports#update"
  patch "reports/:id", to: "reports#update"

# INVOICES
  get "invoices/admin", to: "invoices#index", as: :invoices
  get "invoices/new", to: "invoices#new", as: :new_invoice
  post "invoices/new", to: "invoices#create"
  get "invoices/:id", to: "invoices#show", as: :invoice
  get "invoices/:id/edit", to: "invoices#edit", as: :edit_invoice
  post "invoices/edit", to: "invoices#update"
  patch "invoices/:id", to: "invoices#update"

# ACCOUNTS
  get "accounts/admin", to: "accounts#index", as: :manage_accounts
  get "accounts/new", to: "accounts#new", as: :new_account
  post "accounts/new", to: "accounts#create_new"
  get "accounts/create", to: "accounts#new_create", as: :create_account
  post "accounts/create", to: "accounts#create"
  get "accounts/:id", to: "accounts#show", as: :account
  get "accounts/:id/edit", to: "accounts#edit", as: :edit_account
  post "accounts/edit", to: "accounts#update"
  patch "accounts/:id", to: "accounts#update"

# USERS
  get "users/admin", to: "users#index", as: :manage_users
  get "users/admin/:id", to: "password_resets#create_user"
  post "users/admin/:id", to: "password_resets#create_user", as: :user_reset_pw
  get "users/new", to: "users#new", as: :new_user
  post "users/new", to: "users#create_user_referral"
  get "users/create", to: "users#new_create", as: :create_user
  post "users/create", to: "users#create"
  get "users/:id", to: "users#show", as: :user
  get "users/:id/edit", to: "users#edit", as: :edit_user
  post "users/edit", to: "users#update"
  patch "users/:id/edit", to: "users#update"
  get "users/edit/me", to: "users#edit_user", as: :user_edit
  patch "users/edit/me", to: "users#update_user"

# SIGNUP CONFIRMATION EMAIL
  resources :users do
    member do
      get :confirm_email
    end
  end

# REFERRALS
  resources :users do
    member do
      get :referral_email
    end
  end
  get "users/new2", to: "users#referral", as: :account_referral

# SESSIONS
  get "login", to: "sessions#new", as: :log_in
  post "login", to: "sessions#create"
  get "logout", to: "sessions#destroy"
  delete "logout", to: "sessions#destroy", as: :log_out

# PASSWORD RESETS
  get "users/edit/password", to: "passwords#edit", as: :edit_password
  patch "users/edit/password", to: "passwords#update"
  get "users/reset", to: "password_resets#new", as: :reset_password
  post "users/reset", to: "password_resets#create", as: :reset_pw_post
  get "users/reset/edit", to: "password_resets#edit", as: :pw_reset_edit
  patch "users/reset", to: "password_resets#update", as: :update_password

# REFERRAL RESETS
  get "users/referrals", to: "main#courier", as: :courier
  post "users/referrals", to: "main#path", as: :courier_path

  get "referrals/:referral_key", to: "users#new_referral", as: :referral_new
  post "referrals/:referral_key", to: "users#create_referral"

  get "users/referrals/edit", to: "referrals#edit", as: :courier_edit
  patch "users/referrals", to: "referrals#update", as: :update_courier

# REFERRAL TEST
  get "users/new", to: "referrals#new", as: :new_referral
  post "users/reset", to: "referrals#create", as: :post_referral
  get "users/reset/edit", to: "referrals#confirm", as: :confirm_referral
  patch "users/reset", to: "referrals#update", as: :update_referral

# CSV EXPORTS
  get "accounts/export", to: "accounts#export", as: :export_accounts
  get "users/export", to: "users#export", as: :export_users
  get "pets/export", to: "pets#export", as: :export_pets
  get "walks/export", to: "walks#export", as: :export_walks
  get "clients/export", to: "clients#export", as: :export_clients
  get "invoices/export", to: "invoices#export", as: :export_invoices
  get "invoices/:id/export_client", to: "invoices#export_client", as: :export_invoice_client

# ERRORS
  get "errors/not_found"
  get "errors/internal_server_error"

  match "/404", to: "errors#not_found", via: :all
  match "/500", to: "errors#internal_server_error", via: :all

# FEEDBACK
  get "contact/feedback", to: "feedback#index", as: :feedback
  post "contact/feedback", to: "feedback#path", as: :feedback_path

  get "contact/feedback/beta", to: "beta_feedback#new", as: :beta_feedback
  post "contact/feedback/beta", to: "beta_feedback#path", as: :beta_path
end
