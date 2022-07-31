require_relative 'date_helper.rb'

class TrashDay
  def text()
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
        ""
      end
    end
  end

  def non_burnable_text
    date = Date.today
    week = DateHelper.new.week_of_month_for_date(date)
    day = date.strftime('%a')
    if week % 2 == 0
      "不燃・ビン・有害ゴミ"
    else
      "カン・ペットボトル・金属"
    end
  end
