require_relative 'spec_helper'

describe MagicSequence do
  it { expect(described_class).to generate_correct_sequence }
end