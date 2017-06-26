require 'sinatra'

set :environment, :production

get '/' do
  @omikuzi = ['daikichi', 'syoukichi', 'kichi', 'kyou'].sample
  erb :index
end
