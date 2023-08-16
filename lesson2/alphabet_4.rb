
# Создаем массив 
alphabet = ("a".."z").to_a

# создаем пустой хеш
numerized_alphabet = Hash.new 

# счетчик
x = 1

# заполняем хеш буквами и числами
while x <= 26
  for i in alphabet
    numerized_alphabet[i] = x
    x += 1
  end
end

# создаем список гласных букв

vowels = ['a','e','i','o','u','y']

# создаем новый массив, методом селект прогоняем массив всего алфавита (выбираем из него нужное) и ставим условие содержится ли в массиве гласных ключ? если тру до добавим
numerized_vowels = numerized_alphabet.select { |key, value| vowels.include?(key)}

puts numerized_vowels