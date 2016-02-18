string = "does this work?"

puts string.split.each { |ele| ele.capitalize! }.join(" ")