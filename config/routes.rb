Rails.application.routes.draw do
  root "application#message"
  post "/", to: "application#message"
end
