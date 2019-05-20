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
         "Что такое \"#{message}\"?",
         "\"#{message}\"... Хорошо сказано",
         "Насчет \"#{message}\"... Это долгая история"].sample
      end
      render status: :ok, plain: "ok"
    end
  end
end
