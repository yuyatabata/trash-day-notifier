class LinebotController < ApplicationController
  require 'line/bot'  # gem 'line-bot-api'
  require_relative 'trash_day.rb'

  # callbackアクションのCSRFトークン認証を無効
  # protect_from_forgery :except => [:callback]

  def callback
    client = Line::Bot::Client.new { |config|
      config.channel_secret = ENV["LINE_CHANNEL_SECRET"]
      config.channel_token = ENV["LINE_CHANNEL_TOKEN"]
    }
    message = {
      type: 'text',
      text: trash_day.text
    }  
    client.push_message(ENV["LINE_ID_OF_GROUP"], message)
  end
end
