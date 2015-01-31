require_relative 'base_sequence'

class SimpleSequence < BaseSequence

  private

  def generate_sequence
    (@count - 1).times do
      new_item = get_item_by(@sequence.last)
      @sequence.push(new_item)
    end
  end


  def get_item_by(el)
    number = el[0]
    count = 1

    String.new.tap do |str|
      el.length.times do |i|
        if el[ i + 1 ] == number
          count += 1
        else
          str << "#{ count }#{ number }"
          count = 1
          number = el[ i + 1 ]
        end
      end
    end
  end
end
