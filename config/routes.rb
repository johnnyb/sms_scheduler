Rails.application.routes.draw do
	resources :scheduled_messages do
	end

	resources :cases
end
