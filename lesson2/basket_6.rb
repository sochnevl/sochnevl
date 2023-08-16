hash = Hash.new

loop do
  puts "Введите название товара. Если хоите прекратить введите 'стоп'."
  products = gets.chomp.downcase

  break if products == "стоп"

  puts "Введите стоимость товара: "
  cost = gets.chomp.to_f

  puts "ВВедите количество единиц товара: "
  quantity = gets.chomp.to_i
  
  hash[products.to_sym] = {cost => quantity}

    
end

total_cost = 0
hash.each do |key, value|
  value.each do |key_value, value_value|
    total_cost += key_value * value_value
  end
end

puts hash

puts total_cost