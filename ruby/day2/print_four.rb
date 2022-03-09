# print the contents of an array of sixteen numbers, four numbers at a time, using just each

a = (1..16)

temp = []
a.each do |i|
  temp.push(i)
  if temp.length == 4
    puts temp.join(' ')
    temp.clear
  end
end

# now do the same with each_slice in enumerable
a.each_slice(4) { |s| puts s.join(' ') }
