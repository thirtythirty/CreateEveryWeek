price = [650, 780, 980]
# [286, 3, 12]

target_value = 200010

table = Array.new(target_value+1, -1)
anser_table = Array.new(target_value+2) {
  Array.new(3, 0)
}

table[0] = 0
table[1] = 0
now_price = 1
loop do
  break if now_price+price[0] > target_value+1
  table[now_price+price[0]] = table[now_price]+1
  anser_table[now_price+price[0]][0] = anser_table[now_price][0]+1
  anser_table[now_price+price[0]][1] = anser_table[now_price][1]
  anser_table[now_price+price[0]][2] = anser_table[now_price][2]

  now_price += price[0]
end
p table

table.each_with_index do |t, index|
  if table[index+1] == -1
    if index+1 - price[1] > 0
      if table[index+1 - price[1]] == -1
        # 不成立
      else
        table[index+1] = table[index+1 - price[1]] + 1
        anser_table[index+1][1] = anser_table[index+1 - price[1]][1]+1
        anser_table[index+1][2] = anser_table[index+1 - price[1]][2]
        anser_table[index+1][0] = anser_table[index+1 - price[1]][0]
      end
    else
      next
    end
  else
    next
  end
end

p table

table.each_with_index do |t, index|
  if table[index+1] == -1
    if index+1 - price[2] > 0
      if table[index+1 - price[2]] == -1
        # 不成立
      else
        table[index+1] = table[index+1 - price[2]] + 1
        anser_table[index+1][2] = anser_table[index+1 - price[2]][2] + 1
        anser_table[index+1][1] = anser_table[index+1 - price[2]][1]
        anser_table[index+1][0] = anser_table[index+1 - price[2]][0]
      end
    else
      next
    end
  else
    next
  end
end

p table
p anser_table
