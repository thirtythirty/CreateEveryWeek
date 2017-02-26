set_time = 10

puts "10秒当てゲーム！"
puts "(いかに10秒間の経過を当てられるか競うゲーム)"
puts "Enterキーを押してスタート!(再びエンターキーでストップ)"
gets
start_time = Time.now
puts "Enterキーでストップ:"
gets

between_time = Time.now-start_time
puts "ただいまの経過時間は#{between_time}秒です。"
gosa = 10 - between_time
puts "誤差は#{gosa}秒"

print "評定は..."
if gosa < 0.01
	puts "SS"
elsif gosa < 0.1
	puts "S"
elsif gosa < 1
	puts "A"
elsif gosa < 2
	puts "B"
elsif gosa < 3
	puts "C"
elsif gosa < 5
	puts "D"
elsif gosa < 10
	puts "E"
else
	puts "F"
end
