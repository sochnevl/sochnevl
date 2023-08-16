
# Создаем хэш месяцев , в котором ключи - номер месяца, значения - кол-во дней в месяце
# для ключа 2 (февраль), знаечние ставим nil, заполним его позднее
month = {
 	1 => 31,
 	2 => nil,
 	3 => 31,
 	4 => 30,
 	5 => 31,
 	6 => 30,
 	7 => 31,
 	8 => 31,
 	9 => 30,
 	10 => 31,
 	11 => 30,
 	12 => 31
}

# Просим у пользователя ввод
puts "Введите число: "
day_choice = gets.chomp.to_i 

puts "Введите месяц: "
month_choice = gets.chomp.to_i
  
puts "Введите год: "
year_choice = gets.chomp.to_i

puts "Вы ввели дату: #{day_choice}/#{month_choice}/#{year_choice}"

# создаем пустой массив дней в году
days_in_year =[]

#заполним массив от 1 до 365 или 366 (високосный или нет)
if year_choice % 4 == 0   
  if year_choice % 100 == 0 
    if year_choice % 400 == 0 
      days_in_year = (1..366).to_a # год високосный
    else
      days_in_year = (1..365).to_a  # год не високосный
    end    
  else
    days_in_year = (1..366).to_a  # год  високосный
  end	
else
  days_in_year = (1..365).to_a  # год не високосный
end

# присвоим в хеше month ключу 2 (февраль) значение в зависимости от того, високосный год или нет
if days_in_year[-1] == 366
  month[2] = 29
else
  month[2] = 28
end

# подсчитаем порядковый номер выбранногодня в году
# создаем переменную равную нулю, затема в цикле переберем range от 1 до выбранного месяца пользователем,
# не включительно. В каждом круге цикла прибавляем знаечние хеша month в days_count
days_count = 0
for i in 1...month_choice
  days_count += month[i]
end

# к полученному числу прибавим введенный пользователем день и получим порядковый номер этого дня в году
serial_number = days_count + day_choice

puts "Порядковый номер дня в году: #{serial_number}"
