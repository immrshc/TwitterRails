Rails.application.routes.draw do
  match ':controller(/:action(/:id))', via: [ :get, :post, :patch ]

  namespace :authentication do
  	post 'sign_in' => 'sign_in#sign_in'
	post 'sign_up' => 'sign_up#sign_up'
  end
 
  namespace :timeline do
  	get 'test' => 'timeline#test'
  	post 'show' => 'timeline#show_timeline'
	post 'show/reply' => 'timeline#show_reply'
	post 'show/mypost' => 'timeline#show_mypost'
	post 'show/myfavorite' => 'timeline#show_myfavorite'
  end

  namespace :post do
  	get 'test' => 'post#test'
  	post 'without' => 'post#upload'
	post 'with' => 'post#upload_with_image'
	get 'download/image' => 'post#download_image'
  end
  
end
