module Enumerable


def my_each
  length.times do |i|
    yield to_a[i]
  end
end

def my_each_with_index
  length.times do |i|
    yield to_a[i], i
  end
end

def my_select 
  choice = []
  length.times do |i|
    evaluation = yield to_a[i] 
    choice.push(to_a[i]) if evaluation == true
  end
end

puts "This is my-each method"

[1, 2, 3, 4, 5, 6, 7,].my_each { |num| puts num }

[1, 2, 3, 4, 5, 6, 7,].my_each_with_index { |num, i| puts "#{i} : #{num}" }

[1, 2, 3, 4, 5, 6, 7,].my_select { |num| puts num if num.even? }
end






