# Write a simple grep that will print the lines of a file having any occurrences of a phrase anywhere in that line.

pattern = ARGV[0]
filename = ARGV[1]

File.foreach(filename) do |line|
  puts "#{$INPUT_LINE_NUMBER} #{line}" if Regexp.new(pattern).match(line)
end
