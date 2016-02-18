def uuid
  arr = []
  (0..9).each { |num| arr << num.to_s }
  ('a'..'f').each { |char| arr << char }
  id = ''
  8.times { id << (arr.sample) }
  id << '-'
  4.times { id << (arr.sample) }
  id << '-'
  4.times { id << (arr.sample) }
  id << '-'
  4.times { id << (arr.sample) }
  id << '-'  
  12.times { id << (arr.sample) }  
  id
end

puts uuid

def uuid2
  arr = []
  (0..9).each { |num| arr << num.to_s }
  ('a'..'f').each { |char| arr << char }
  id = ''
  serials = [8, 4, 4, 4, 12]
  serials.each do |serial|
    serial.times { id << (arr.sample) }
    id << '-' unless serial == 12
  end
  id
end

puts uuid2