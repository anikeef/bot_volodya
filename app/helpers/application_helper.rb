module ApplicationHelper
  def answer #Accepts a block
    user_id = params["object"]["from_id"]
    message_id = params["object"]["id"]
    message = params["object"]["text"]
    modified_message = CGI.escape(yield(message))
    random_id = Random.rand(10000000)
    thread = Thread.new do
      RestClient.get "https://api.vk.com/method/messages.markAsRead?start_message_id=#{message_id}&access_token=#{ENV["VK_KEY"]}&v=5.95"
      RestClient.get "https://api.vk.com/method/messages.send?user_id=#{user_id}&random_id=#{random_id}&message=#{modified_message}&reply_message=#{message_id}&access_token=#{ENV["VK_KEY"]}&v=5.95"
    end
    thread.join
  end
end
