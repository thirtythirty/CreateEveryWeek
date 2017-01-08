set_time = (ARGV[0] || 1).to_i * 60

start_time = Time.now

put_string = ("a".."z").to_a

while true do
	count = set_time - (Time.now-start_time)
	print count.to_i
	20.times do
	  print put_string.sample
	end
	if(count < 0)
		break
	end
	sleep(0.01)
end

puts "\nend"
