Rails.application.routes.draw do
  root "application#request"
  post "/", to: "application#request"
end
