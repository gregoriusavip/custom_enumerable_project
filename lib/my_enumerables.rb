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
