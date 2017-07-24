require 'sinatra'
require 'sinatra/reloader'
require 'date'

require './lib/month_calender.rb'

# set :environment, :production

get '/:year/:month' do
  year = params[:year].to_i || 2017
  month = params[:month].to_i || 7
  @month_calender = MonthCalender.new(year, month)
  @last_month_path =
    if month != 1
      "/#{year}/#{month-1}"
    else
      "/#{year-1}/12"
    end

  @next_month_path =
    if month != 12
      "/#{year}/#{month+1}"
    else
      "/#{year+1}/1"
    end

  @this_month_path = "/#{Date.today.year}/#{Date.today.month}"

  erb :index
end