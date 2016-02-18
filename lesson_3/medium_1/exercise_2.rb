statement = "The Flintstones Rock"

hash = Hash.new(0)

statement.each_char do |c|
  next if c == ' '
  if hash.has_key?(c)
    hash[c] += 1
  else
    hash[c] = 1
  end
end

p hash