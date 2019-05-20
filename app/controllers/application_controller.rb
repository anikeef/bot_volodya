require "rest-client"
require "cgi"

class ApplicationController < ActionController::API
  include ApplicationHelper

  def message
    case params["type"]
    when "confirmation"
      render plain: "#{ENV["VK_CONFIRM"]}"
      return
    when "message_new"
      answer do |message|
        random_word = message.split(" ").sample
        ["#{message}? Хороший вопрос",
         "Что значит \"#{random_word}\"?",
         "\"#{message}\"... Хорошо сказано",
         "#{message}? Хм, никогда об этом не думал",
         "Я тоже думаю, что #{random_word}",
         "Можно поподробнее про \"#{random_word}\"?",
         "Кстати насчет \"#{random_word}\"... Это долгая история",
         "Почему #{random_word}?"].sample
      end
      render status: :ok, plain: "ok"
    end
  end
end
