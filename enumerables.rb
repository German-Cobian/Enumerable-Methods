module Enumerable


def my_each
  return to_enum(:my_each) unless block_given?

  self.length.times do |i|
    yield (to_a[i])
  end
  self
end

def my_each_with_index
  return to_enum(:my_each_with_index) unless block_given?

  self.length.times do |i|
    yield to_a[i], i
  end
end

def my_select 
  return to_enum(:my_select) unless block_given?

  result = []
  self.my_each { |i| result << i unless !yield(i) }
  result
end

def my_all 
  return to_enum(:my_all) unless block_given?

  result = true
  self.my_each{ |i| result = false unless yield(i)}
  result 
end

def my_any 
  return to_enum(:my_any) unless block_given? 

  result = false
    self.my_each { |i| result = true if yield(i) }
    result
end
  
def my_none 
  return to_enum(:my_none) unless block_given? 

  result = true
    self.my_each { |i| result = false if yield(i) }
    result
end

def my_count
  return to_enum(:my_count) unless block_given? 

  result = 0
  self.my_each { |i| result += 1 if yield(i) }
  result
end

def my_map
  return to_enum(:my_map) unless block_given? 

  mapped = []
  self.length.times do |i|
    doubled = yield to_a[i]
    mapped.push(doubled)
  end
  mapped
end

    
puts "Output for my_each method"

test_array = [1, 2, 3, 4, 5, 6, 7, 8]

p test_array.my_each { |num| puts num }

puts "Output for my_each_with_index method"

p test_array.my_each_with_index { |num, i| puts "#{i} : #{num}" }

puts "Output for my_select method"

p test_array.my_select { |num| puts num if num.even? } 

puts "Output for my_all method"

p test_array.my_all { |num| num%1 == 0 }

puts "Output for my_any method"

p test_array.my_any { |num| num%9 == 0 }

puts "Output for my_none method"

p test_array.my_none { |num| num%8 == 0 }

puts "Output for my_count method"

p test_array.my_count 

puts "Output for my_map method" 

p test_array.my_map { |num| num * 2 } 

end 





