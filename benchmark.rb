require_relative 'sequence/simple_sequence'
require_relative 'sequence/magic_sequence'
require 'benchmark'

Benchmark.bm do |x|
  x.report { Sequence::SimpleSequence.new(35).generate }
  x.report { Sequence::MagicSequence.new(35).generate }
end