require 'sinatra'
require 'sinatra/reloader'
require 'date'
require 'uri'

require './lib/month_calender.rb'
require './lib/year_calender.rb'
require './lib/era_calender.rb'

# set :environment, :production

get '/era/:era_name' do
  era_name = params[:era_name].force_encoding("UTF-8")

  unless(era_name == '明治' || era_name == '大正' ||
         era_name == '昭和' || era_name == '平成')
    return "その元号は存在しません"
  end
  @era_calender = EraCalender.new(era_name)

  erb :era_calender
end

get '/:year/:month' do
  year = params[:year].to_i
  month = params[:month].to_i
  @month_calender = MonthCalender.new(year, month)

  @last_month_path = if month != 1
                       "/#{year}/#{month-1}"
                     else
                       "/#{year-1}/12"
                     end
  @next_month_path = if month != 12
                       "/#{year}/#{month+1}"
                     else
                      "/#{year+1}/1"
                     end
  @this_month_path = "/#{Date.today.year}/#{Date.today.month}"


  erb :index
end

get '/:year' do
  year = params[:year].to_i
  @year_calender = YearCalender.new(year)

  @last_year_path = "/#{year-1}"
  @next_year_path = "/#{year+1}"
  @this_year_path = "/#{Date.today.year}"

  erb :year_calender
end