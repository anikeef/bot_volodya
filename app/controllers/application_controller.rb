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
      answer { |message| "#{message}? Хорошо сказано"}
      render status: :ok, plain: "ok"
    end
  end
end
