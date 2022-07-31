require_relative 'trash_day.rb'

namespace :push_line do
  desc "明日のゴミ出し"
  task push_line_message_trash: :environment do
    trash_day = TrashDay.new
    users = [ { uid: 1, name: ENV["NAME_OF_PERSON_IN_CHARGE_1"] }, { uid: 2, name: ENV["NAME_OF_PERSON_IN_CHARGE_2"] }]

    client = Line::Bot::Client.new { |config|
      config.channel_secret = ENV["LINE_CHANNEL_SECRET"]
      config.channel_token = ENV["LINE_CHANNEL_TOKEN"]
    }
    users.each do |user|
      message = {
        type: 'text',
        text: trash_day.text(user['name'])
      }  
      client.push_message(ENV["LINE_ID_OF_GROUP"], message)
    end
  end
end