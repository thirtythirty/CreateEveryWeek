require 'date'
require './lib/day.rb'
require './lib/event.rb'

class MonthCalender
  attr_accessor :year, :month, :maxday, :days, :era_name

  def initialize(year, month)
    @year = year.to_i
    @month = month.to_i
    @month_name = MonthCalender.convert_to_month_name(@month)
    @maxday = get_maxday(@year, @month)
    first_wday = get_wday(@year, @month, 1)
    @days = []
    @maxday.times do |i|
      @days << Day.new(i+1, (first_wday+i)%7)
    end
    @era_name = Day.getEraName(@year, @month, 1)
    
    setEvents()
  end

  def get_maxday(year, month)
    if(month == 2)
     if(year%4 == 0 && (year%100 != 0 || year%400 == 0))
       return 29
     end
    end
    maxdays = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
    return maxdays[month-1]
  end

  def get_wday(year,month,day)
    if(month == 1 || month == 2)
      month+=12
      year-=1
    end
    (year + (year/4).floor - (year/100).floor + (year/400).floor + (((13*month) + 8)/5).floor + day)%7
  end

  def setEvents()
    Event.day_events[@month_name]&.[]('constant_event')&.each do |event|
      target_day = @days[event['date']-1]
      if(check_vaild_event?(target_day.day_num, from_str: event['from'], end_str: event['end']))
        target_day.setEvent(event['name'], event['type'])
      end
    end
    Event.day_events[@month_name]&.[]('dynamic_event')&.each do |event|
      target_day = select_day_by_week_and_wday(event['week'], event['wday'])
      if(check_vaild_event?(target_day.day_num, from_str: event['from'], end_str: event['end']))
        target_day.setEvent(event['name'], event['type'])
      end
    end
    set_compensatory_holiday()
    set_spring_equinox_day()
    set_autumnal_equinox_day()
  end

  def select_day_by_week_and_wday(week_name, wday_name)
    week_num = MonthCalender.convert_to_week_number(week_name)
    wday_num = MonthCalender.convert_to_wday_number(wday_name)
    first_day_wday_num = @days[0].wday_num
    select_day_index = (7-(first_day_wday_num - wday_num))%7+(week_num-1)*7
    if(0 <= select_day_index && select_day_index < @maxday)
      return @days[select_day_index]
    else
      return nil
    end
  end

  def set_compensatory_holiday()
    %w(first_week second_week third_week fourth_week fifth_week).each do |week|
      sunday = select_day_by_week_and_wday(week, 'Sunday')
      if(sunday && sunday.is_public_holiday?)
        @days[sunday.day_num].setEvent('振替休日', 'public_holiday')
      end
    end
  end

  def set_spring_equinox_day()
    if(@month != 3)
      return;
    end
    spring_equinox_day =
      (20.8431 + 0.242194 * (@year - 1980)).to_i - ((@year - 1980)/4).to_i
    @days[spring_equinox_day-1].setEvent('春分の日', 'public_holiday')
  end

  def set_autumnal_equinox_day()
    if(@month != 9)
      return;
    end
    autumnal_equinox_day =
      (23.2488 + 0.242194 * (@year - 1980)).to_i - ((@year - 1980) /4).to_i
    @days[autumnal_equinox_day-1].setEvent('秋分の日', 'public_holiday')
  end

  def check_vaild_event?(day_num, from_str: nil, end_str: nil)
    target_date = Date.new(@year, @month, day_num)
    if(from_str != nil)
      from_date = Date.strptime(from_str, '%Y/%m/%d')
      return false if(from_date > target_date)
    end
    if(end_str != nil)
      end_date = Date.strptime(end_str, '%Y/%m/%d')
      return false if(end_date < target_date)
    end
    # 有効
    return true
  end

  def self.convert_to_week_number(week_name)
    @week_numbers ||= { 'first_week': 1, 'second_week': 2,
                        'third_week': 3, 'fourth_week': 4,
                        'fifth_week': 5
                      }
    return @week_numbers[week_name.to_sym]
  end

  def self.convert_to_wday_number(wday_name)
    @wday_numbers ||= { 'Sunday': 0, 'Monday': 1, 'Tuesday': 2,
                        'Wednesday': 3, 'Thursday': 4,
                        'Friday': 5, 'Saturday': 6
                      }
    return @wday_numbers[wday_name.to_sym]
  end

  def self.convert_to_month_name(month)
    @month_names ||= { '1': 'January', '2': 'February', '3': 'March',
                       '4': 'April', '5': 'May', '6': 'June', '7': 'July',
                       '8': 'August', '9': 'September', '10': 'October',
                       '11': 'November', '12': 'December',
                     }
    return @month_names[month.to_s.to_sym]
  end
end