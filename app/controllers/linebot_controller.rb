class LinebotController < ApplicationController
  require 'line/bot'  

  def callback
    client = Line::Bot::Client.new { |config|
      config.channel_secret = ENV["LINE_CHANNEL_SECRET"]
      config.channel_token = ENV["LINE_CHANNEL_TOKEN"]
    }
    message = {
      type: 'text',
      text: trash_day
    }  
    client.push_message(ENV["LINE_ID_OF_GROUP"], message)
  end

  def trash_day
    user_1 = ENV["NAME_OF_USER_IN_CHARGE_1"]
    user_2 = ENV["NAME_OF_USER_IN_CHARGE_2"]

    date = Date.today

    case date.strftime('%a')
    when "Mon"
      "#{user_1}！明日は可燃ゴミの日やでぇ！今のうちにまとめときや〜！"
    when "Tue"
      "#{user_2}！明日はプラスチックと古紙・布の日やでぇ！今のうちにまとめときや〜！"
    when "Thu"
      "#{user_2}！明日は可燃ゴミの日やでぇ！今のうちにまとめときや〜！"
    when "Sun"
      "#{user_1}！明日は#{non_burnable_text}の日やでぇ！今のうちにまとめときや〜！"
    else
      "明日は何も無い日やでぇ！"
    end
  end

  def non_burnable_text
    date = Date.today
    week = week_of_month_for_date(date)
    day = date.strftime('%a')
    if week % 2 == 0
      "不燃・ビン・有害ゴミ"
    else
      "カン・ペットボトル・金属"
    end
  end

  def week_of_month_for_date(date)
    my_date = Time.zone.parse(date.to_s)
    week_of_target_date = my_date.strftime("%U").to_i
    week_of_beginning_of_month = my_date.beginning_of_month.strftime("%U").to_i
    week_of_target_date - week_of_beginning_of_month
  end
end

