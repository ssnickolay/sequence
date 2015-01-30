require_relative 'spec_helper'

describe SimpleSequence do
  it { expect(described_class).to generate_correct_sequence }
end