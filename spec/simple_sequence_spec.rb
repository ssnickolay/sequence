require_relative 'spec_helper'

describe Sequence::Simple do
  it { expect(described_class).to generate_correct_sequence }
end