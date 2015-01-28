require_relative '../simple_sequence'

describe SimpleSequence do
  let(:sequence) { SimpleSequence.new(6) }

  subject do
    sequence.generate
    sequence.sequence
  end

  it { should eq %w(1 11 21 1211 111221 312211) }
end