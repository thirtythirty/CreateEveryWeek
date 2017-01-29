puts "ねえ、じゃんけんしようよ！"
ken = 0
ken_name = ["グー","チョキ","パー"]
ken_initial = ['g', 'y', 'p']
while true do
	print "じゃ〜んけ〜ん(グー:g,チョキ:y,パー:p)"
	ken_s = gets.chomp[0]
	ken = -1
	ken_initial.each_with_index do |item,i| 
		if(ken_s == ken_initial[i])
			ken = i
		end
	end
	if(ken == -1)
		puts("なにそれ？")
		next
	end

	cpu_ken = rand(3)
	puts ("坊や:" + ken_name[cpu_ken])

	if(ken == cpu_ken)
		puts("あ〜いこ〜で")
	elsif((ken == 0 && cpu_ken == 1) || (ken == 1 && cpu_ken == 2) || (ken == 2 && cpu_ken == 0))
	  puts("や〜ら〜れ〜た〜")
	  break
	else	
		puts("やったー僕の勝ち")
		break
	end
end

