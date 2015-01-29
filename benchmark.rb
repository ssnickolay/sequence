require_relative 'simple_sequence'
require 'benchmark'

Benchmark.bm do |x|
  x.report { Sequence::SimpleSequence.new(60).generate }
end