require "rest-client"

class ApplicationController < ActionController::API
  def request
    case params["type"]
    when "confirmation"
      render text: "#{ENV["VK_CONFIRM"]}"
    when "message_new"
      user_id = params["object"]["from_id"]
      message = params["object"]["text"]
      modified_message = "#{message}? Хороший вопрос"
      random_id = rand(10000000000)
      RestClient.post "https://api.vk.com/method/messages.send?user_id=#{user_id}&random_id=#{random_id}&message=#{modified_message}&access_token=#{ENV["VK_KEY"]}&v=5.95"
      render text: "ok"
    end
  end
end
