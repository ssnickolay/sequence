require 'pry'
module Sequence
  class MagicSequence
    attr_reader :sequence

    def initialize(count = 100)
      @count = count
      @sequence = []
    end

    def generate
      @sequence = %w(1)
      @current_repeats = []
      @current_units = [0]
      current_el = %w(1)

      (@count - 1).times do
        @next_units = []
        @next_repeats = []

        current_el = generate_item(current_el)
        @sequence.push(current_el.join)

        @current_repeats = @next_repeats
        @current_units = @next_units
      end
    end

    private

    def generate_item(el)
      i = 0
        [].tap do |arr|
        while i < el.count
          binding.pry #if el.count > 3
          if @current_repeats.any?
            repeat_index = @current_repeats.shift

           # next if repeat_index < i

            repeat_el = el[repeat_index]

            arr.concat(only_units(el[i ... repeat_index], arr, el.count, i, i += repeat_index)) if i != repeat_index
            count = find_repeat_count(el, i, repeat_el)

            @next_repeats << arr.count - 1 if arr.last == count.to_s
            arr.concat([ count.to_s, repeat_el ])

            @next_repeats << arr.count - 2 if repeat_el == count.to_s
            @next_units   << arr.count - 1 if repeat_el == '1'

            i += count
          else
            arr.concat(only_units(el[i .. el.count], arr.count, el.count, i, i = el.count))
          end
        end
      end
    end

    def only_units(el, arr_count, el_count, i_current, i_next)
      # [2, 3, 4, 1] => [1, 2, 1, 3, 1, 4, 1, 1]
      result = "1#{ el.join('1') }".split('')
      @next_repeats.concat( @current_units.select{ |u| u < i_next && u >= i_current }.map { |u| u - (el_count - (arr_count + result.count)) } )
      @next_units.concat( (i_current ... i_next).map{ |u| u * 2 } ) # на каждое 2ое место встанет 1

      result
    end

    def find_repeat_count(el, i, repeat_el)
      count = 1
      while el[i + count] == repeat_el
        count += 1
      end

      count
    end
  end
end

s = Sequence::MagicSequence.new(6)#9)
s.generate
puts s.sequence