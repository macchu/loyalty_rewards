Rails.application.routes.draw do
  get '/check_ins/', to: 'check_ins#ask_for_location'
  post '/check_ins/ambiguous_store', to: 'check_ins#select_store'
  post '/check_ins/', to: 'check_ins#create'

  post 'patrons', to: 'check_ins#create_patron'  #This one is reached first.

  get 'redemption/', to: 'redemptions#show'
  get 'redemptions/redeem/:redemption_id', to: 'redemptions#edit'
  patch 'redemption', to: 'redemptions#update'

  get 'store/:id/loyalty_card/:id', to: 'loyalty_cards#edit'
 end
  