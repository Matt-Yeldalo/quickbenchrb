require 'benchmark'

# Perform quick benchmarks
class QuickBench
  # Compares two methods, see Benchmark.measure to learn about the output
  #
  # @param [Array] method_names The list of names. E.g. `['method_a', 'method_b']`
  # @param [Proc] a_lambda The first method to test
  # @param [Proc] b_lambda The second method to test
  def self.compare_methods(method_names, a_lambda, b_lambda)
    title = '  User CPU   Sys CPU    Sum      Elapsed Time'

    a_result = Benchmark.measure { a_lambda.call }
    b_result = Benchmark.measure { b_lambda.call }

    wrap_with_box([
                    method_names.first,
                    '',
                    title,
                    '',
                    a_result,
                    ''
                  ])

    wrap_with_box([
                    method_names[1],
                    '',
                    title,
                    '',
                    b_result,
                    ''
                  ])
  end

  # Hide method by putting it on the class, not the same as 'private'
  class << self
    def wrap_with_box(inner_contents)
      puts ' ----------------------------------------------'
      puts '|'
      inner_contents.each do |ic|
        puts '| ' << ic.to_s
      end
      puts '|'
      puts ' ----------------------------------------------'
    end
  end
end

# str = 'X' * 1024 * 1024 * 10 # 10MB String
# str1 = 'X' * 1024 * 1024 * 10 * 10 * 10
#
# stra = 'X' * 1024 * 1024 * 10 # 10MB String
# strb = 'X' * 1024 * 1024 * 10 * 10 * 10

def fun1
  sum = 1
  1_000_000.times do |i|
    sum += i
  end
end

def fun2
  sum = 1
  1_000_000.times do |i|
    sum *= i
  end
end

# QuickBench.compare_methods(['downcase', 'downcase!'], -> { str.downcase }, -> { str.downcase! })

QuickBench.compare_methods(%w[addition multiplication], -> { fun1 }, -> { fun2 })

# QuickBench.compare_methods(['upcase', 'upcase!'], -> { stra.upcase }, -> { stra.upcase! })
