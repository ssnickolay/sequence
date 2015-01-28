require_relative 'simple_sequence'
require 'benchmark'

Benchmark.bm do |x|
  x.report { SimpleSequence.new(60).generate }
end