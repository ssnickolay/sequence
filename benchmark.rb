require_relative 'simple_sequence'
require 'benchmark'

Benchmark.bm do |x|
  x.report { Sequence::Simple.new(60).generate }
end