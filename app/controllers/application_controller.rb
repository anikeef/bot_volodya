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
        ["#{message}? Хороший вопрос",
         "Что значит \"#{message.split(" ").sample}\"?",
         "\"#{message}\"... Хорошо сказано",
         "#{message}? Хм, никогда об этом не думал",
         "Я тоже думаю, что #{message.split(" ").sample}"].sample
      end
      render status: :ok, plain: "ok"
    end
  end
end
