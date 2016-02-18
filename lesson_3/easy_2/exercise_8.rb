flintstones = %w(Fred Barney Wilma Betty BamBam Pebbles)

flintstones.each_with_index { |ele, index| puts index if ele.start_with?('Be') }

puts flintstones.index { |ele| ele.start_with?('Be') }