require './lib/month_calender.rb'
require './lib/year_calender.rb'


class EraCalender
  attr_accessor :months, :era_name

  def initialize(era_name)
    @era_name = era_name
    case @era_name
    when '平成'
      @from_date = Date.new(1989,1,8)
      @end_date = Date.today
    when '昭和'
      @from_date = Date.new(1926,12,25)
      @end_date = Date.new(1989,1,8)
    when '大正'
      @from_date = Date.new(1912,7,30)
      @end_date = Date.new(1926,12,25)
    when '明治'
      @from_date = Date.new(1868,1,25)
      @end_date = Date.new(1912,7,30)
    end

    @months = []
    (@from_date.year..@end_date.year).each do |year|
      start_month = (year == @from_date.year) ? @from_date.month : 1
      end_month = (year == @end_date.year) ? @end_date.month : 12

      (start_month..end_month).each do |month|
        @months << MonthCalender.new(year, month)
      end
    end
    @months[0].days[@from_date.day-1]
      .setEvent("#{@era_name}の始まり", 'event')
    @months[-1].days[@end_date.day-1]
      .setEvent("#{@era_name}の終わり", 'event')
  end
end