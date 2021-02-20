# rubocop:disable Style/CaseEquality, Metrics/ModuleLength, Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity
module Enumerable
  def my_each
    return to_enum(:my_each) unless block_given?

    to_a.length.times do |i|
      yield(to_a[i])
    end
    self
  end

  def my_each_with_index
    return to_enum(:my_each_with_index) unless block_given?

    to_a.length.times do |i|
      yield(to_a[i], i)
    end
    self
  end

  def my_select
    return to_enum(:my_select) unless block_given?

    result = []
    to_a.my_each { |i| result << i if yield(i) }
    result
  end

  def my_all?(param = nil)
    if !block_given? && !param
      to_a.my_each { |val| return false unless val }
    elsif param.is_a?(Class)
      to_a.my_each { |val| return false unless val.is_a?(param) }
    elsif param.is_a?(Regexp)
      to_a.my_each { |val| return false unless param.match(val) }
    elsif param
      to_a.my_each { |val| return false unless val == param }
    else
      to_a.my_each { |val| return false unless yield(val) }
    end
    true
  end

  def my_any?(param = nil)
    if !block_given? && !para
      to_a.my_each { |val| return true if val }
    elsif param.is_a?(Class)
      to_a.my_each { |val| return true if val.is_a?(param) }
    elsif param.is_a?(Regexp)
      to_a.my_each { |val| return true if param.match(val) }
    elsif param
      to_a.my_each { |val| return true if val == param }
    else
      to_a.my_each { |val| return true if yield(val) }
    end
    false
  end

  def my_none?(param = nil)
    if !block_given? && !param
      to_a.my_each { |val| return false if val }
    elsif param.is_a?(Regexp)
      to_a.my_each { |val| return false if param.match(val) }
    elsif param.is_a?(Class)
      to_a.my_each { |val| return false if val.is_a?(param) }
    elsif param
      to_a.my_each { |val| return false if val == param }
    else
      to_a.my_each { |val| return false if yield(val) }
    end
    true
  end

  def my_count(param = nil)
    counter = 0
    if block_given?
      to_a.my_each { |val| counter += 1 if yield(val) }
    elsif para
      to_a.my_each { |val| counter += 1 if param == val }
    else counter = to_a.length
    end
    counter
  end

  def my_map(my_proc = nil)
    return to_enum(:my_map) unless block_given? || my_proc

    arr = []
    if my_proc
      to_a.my_each { |val| arr << my_proc.call(val) }
    else
      to_a.my_each { |val| arr << yield(val) }
    end
    arr
  end

  def my_inject(initial_1 = nil, initial_2 = nil)
    if initial_1.is_a?(Symbol) && !initial_2
      memo = to_a[0]
      1.upto(to_a.length - 1) { |i| memo = memo.send(initial_1, to_a[i]) }
    elsif !initial_1.is_a?(Symbol) && initial_2.is_a?(Symbol)
      memo = initial_1
      0.upto(to_a.length - 1) { |i| memo = memo.send(initial_2, to_a[i]) }
    elsif block_given? && initial_1
      memo = initial_1
      to_a.my_each { |val| memo = yield(memo, val) }
    elsif block_given? && !initial_1
      memo = to_a[0]
      1.upto(to_a.length - 1) { |i| memo = yield(memo, to_a[i]) }
    elsif !block_given? && !initial_1
      raise LocalJumpError
    else
      return 'input error'
    end
    memo
  end

  def multiply_els(arr)
    arr.my_inject(:*)
  end
end
# rubocop:enable Style/CaseEquality, Metrics/ModuleLength, Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity
