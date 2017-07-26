require './lib/month_calender.rb'

class YearCalender
  attr_accessor :year, :months, :era_name

  def initialize(year)
    @year = year.to_i
    @months = []
    12.times do |i|
      @months << MonthCalender.new(@year, i+1)
    end
    @era_name = Day.getEraName(@year, 1, 1)
  end
end