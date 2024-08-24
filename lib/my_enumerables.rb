module Enumerable
  # Your code goes here
  def my_all?(arg = (no_var = true; nil))
    return true if length.eql?(0)

    unless arg.nil? && no_var
      my_each { |elem| return false unless arg === elem }
      return true
    end

    unless block_given?
      my_each { |elem| return false if !!elem }
      return true
    end

    my_each { |elem| return false unless yield(elem) }
    true
  end

  def my_any?(arg = (no_var = true; nil))
    return false if length.eql?(0)

    unless arg.nil? && no_var
      my_each { |elem| return true if arg === elem }
      return false
    end

    unless block_given?
      my_each { |elem| return true unless !!elem }
      return false
    end

    my_each { |elem| return true if yield(elem) }
    false
  end

  def my_count(arg = (no_var = true; nil))
    counter = 0  
    if !(arg.nil? && no_var)
      my_each { |elem| counter += 1 if elem == arg }
    elsif block_given?
      my_each { |elem| counter += 1 if yield(elem) }
    else
      my_each { counter += 1 }
    end
    counter
  end

  def my_each_with_index(*args)
    return to_enum unless block_given?
    index = 0
    my_each do |elem|
      yield(elem, index)
      index += 1
    end
    self
  end

  def my_inject(arg)
    # requires an argument
    my_each { |elem| arg = yield(arg, elem) }
    arg
  end
end

# You will first have to define my_each
# on the Array class. Methods defined in
# your enumerable module will have access
# to this method
class Array
  def my_each
    return to_enum unless block_given?
    length.times { |i| yield(self[i]) }
    self
  end
end
