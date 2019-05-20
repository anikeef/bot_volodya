require "rest-client"
require "cgi"

class ApplicationController < ActionController::API
  def message
    case params["type"]
    when "confirmation"
      render plain: "#{ENV["VK_CONFIRM"]}"
      return
    when "message_new"
      user_id = params["object"]["from_id"]
      message_id = params["object"]["id"]
      message = params["object"]["text"]
      modified_message = CGI.escape("#{message}? Хороший вопрос")
      random_id = Random.rand(10000000)
      RestClient.get "https://api.vk.com/method/messages.send?user_id=#{user_id}&random_id=#{random_id}&message=#{modified_message}&access_token=#{ENV["VK_KEY"]}&v=5.95"
      RestClient.get "https://api.vk.com/method/messages.markAsRead?start_message_id=#{message_id}"
      render status: :ok, text: "ok"
    end
  end
end
