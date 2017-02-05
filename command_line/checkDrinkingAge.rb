require 'date'

t = Date.today 
d_age = Date.new(t.year - 20, t.month, t.day)

puts "今日(#{t.year}年#{t.month}月#{t.day}日)にお酒が飲めるようになった人は"

puts "誕生日が#{d_age.year}年#{d_age.month}月#{d_age.day}日の人です"
