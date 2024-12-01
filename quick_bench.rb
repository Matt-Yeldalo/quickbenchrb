require 'benchmark'

# Perform quick benchmarks
class QuickBench
  # Compares two methods, see Benchmark.measure to learn about the output
  #
  # @param [Hash] opts
  # @options [String] a_name Frist method name
  # @options [String] b_name Second method name
  # @options [Proc] a_lambda Frist method to run
  # @options [Proc] b_lambda Second method to run
  def self.compare_methods(opts)
    title = '  User CPU   Sys CPU    Sum      Elapsed Time'
    opts ||= {}

    puts opts.inspect
    a_lambda = opts[:a_lambda]
    b_lambda = opts[:b_lambda]
    a_name = opts[:a_name]
    b_name = opts[:b_name]

    a_result = Benchmark.measure { a_lambda.call }
    b_result = Benchmark.measure { b_lambda.call }

    wrap_with_box([
                    a_name,
                    '',
                    title,
                    '',
                    a_result,
                    ''
                  ])

    wrap_with_box([
                    b_name,
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

def fib_mem(a, mem)
  return 0 if a < 1

  return 1 if a < 2

  return mem[a.to_s] unless mem[a.to_s]

  mem[a.to_s] = fib_mem(a - 1, mem) + fib_mem(a - 2, mem)
end

def fib(a)
  return 0 if a < 1

  return 1 if a < 2

  fib(a - 1) + fib(a - 2)
end

def fun1
  fib(15)
end

def fun2
  mem = {}
  fib_mem(15, mem)
end

QuickBench.compare_methods({
                             a_name: 'Normal Fib',
                             b_name: 'Fib With Cache',
                             a_lambda: -> { fun1 },
                             b_lambda: -> { fun2 }
                           })

# QuickBench.compare_methods(['downcase', 'downcase!'], -> { str.downcase }, -> { str.downcase! })
# QuickBench.compare_methods(%w[addition multiplication], -> { fun1 }, -> { fun2 })
# QuickBench.compare_methods(['upcase', 'upcase!'], -> { stra.upcase }, -> { stra.upcase! })
