class BaseSequence
  attr_reader :sequence

  def initialize(count = 100)
    @count = count
    @sequence = %w(1)
  end

  def generate
    generate_sequence

    sequence
  end

  private

  def generate_sequence
    fail 'need implementation'
  end
end
