puts "Введите ваше имя: "
name = gets.chomp

puts "Укажите свой рост: "
height = gets.chomp.to_i

ideal_weight = (height - 110) * 1.15

if ideal_weight <= 0
  puts "Ваш вес уже оптимальный"

else 
  puts "#{name}, ваш идельный вес равен #{ideal_weight.round(1)}"
end