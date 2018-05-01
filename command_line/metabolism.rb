puts "体重[kg]"
weight = gets.to_f
puts "身長[cm]"
height = gets.to_f
puts "年齢"
age = gets.to_i
puts "性別[男性:0,女性:1]"
gender = gets.to_i

def metabolism(weight, height, age, gender)
  if(gender == 0)
    return 10 * weight + 6.25 * height -5 * age + 5
  elsif(gender == 1)
    return 10 * weight + 6.25 * height -5 * age - 161
  end
end

puts "あなたの基礎代謝は#{metabolism(weight, height, age, gender)}"
