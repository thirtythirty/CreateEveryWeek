require './lib/event.rb'

class Day
  attr_accessor :wday_num, :day_num, :events

  def initialize(day_num, wday_num)
    @day_num = day_num
    @wday_num = wday_num
    @events = []
  end

  def setEvent(name, type)
    @events << Event.new(name, type)
  end
  
  def kind
    if is_compensatory_holiday?
      return 'compensatory-holiday'
    elsif is_public_holiday?
      return 'public-holiday'
    elsif is_event_day?
      return 'event-day'
    elsif wday_num == 6
      return 'saturday'
    elsif wday_num == 0
      return 'sunday'
    else
      return 'normal'
    end
  end

  def is_public_holiday?
    @events.find {|event| event.type == 'public_holiday' }
  end

  def is_compensatory_holiday?
    @events.find {|event| event.type == 'public_holiday' && event.name == '振替休日' }
  end

  def is_event_day?
    @events.find {|event| event.type == 'event' }
  end

  def self.getEraName(year, month, day)
    target_date = Date.new(year, month, day)
    if(Date.new(1989,1,8) <= target_date)
      '平成'
    elsif(Date.new(1926,12,25) <= target_date)
      '昭和'
    elsif(Date.new(1912,7,30) <= target_date)
      '大正'
    elsif(Date.new(1868,1,25) <= target_date)
      '明治'
    else
      ''
    end
  end
end