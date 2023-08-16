array= []

for x in (10..100)
	if x % 5 == 0
		array.push(x)
	end
end

puts array.to_s
