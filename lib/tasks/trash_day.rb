require_relative 'date_helper.rb'

class TrashDay
  def text(user_name)
    date = Date.today

    case date.strftime('%a')
      when "Mon"
        "#{user_name}! 明日は可燃ゴミの日やでぇ！今のうちにまとめときやあ！"
      when "Tue"
        "#{user_name}! 明日はプラスチックと古紙・布の日やでぇ！今のうちにまとめときやあ！"
      when "Thu"
        "#{user_name}! 明日は可燃ゴミの日やでぇ！今のうちにまとめときやあ！"
      when "Sun"
        "#{user_name}! 明日は#{non_burnable_text}の日やでぇ！今のうちにまとめときやあ！"
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
