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

      @sequence
    end

    private

    def generate_item(el)
      i = 0
        [].tap do |arr|
        while i < el.count
          if @current_repeats.any?
            repeat_index = @current_repeats.shift

            if repeat_index >= i

              repeat_el = el[repeat_index]

              arr.concat(only_units(el, arr, i, i = repeat_index)) if i != repeat_index
              count = find_repeat_count(el, i, repeat_el)

              @next_repeats << arr.count - 1 if arr.last == count.to_s
              arr.concat([ count.to_s, repeat_el ])

              @next_repeats << arr.count - 2 if repeat_el == count.to_s
              @next_units   << arr.count - 1 if repeat_el == '1'

              i += count
            end
          else
            arr.concat(only_units(el, arr, i, i = el.count))
          end
        end
      end
    end

    def only_units(el, new_el, i_current, i_next)
      # [2, 3, 4, 1] => [1, 2, 1, 3, 1, 4, 1, 1]
      joined_el = el[i_current ... i_next]

      result = "1#{ joined_el.join('1') }".split('')
      repeat_units = @current_units.select{ |u| u < i_next && u >= i_current } # значит в куске el есть единицы

      @next_repeats << new_el.count - 1 if new_el.last == '1'

      if repeat_units.any?
        @next_repeats.concat(repeat_units.map{ |u| new_el.count +  (u - i_current) * 2 }) # NEW_EL_COUNT + (index - (ALL_COUNT - EL_COUNT)) * 2 # сдвиг из-за едениц
      end
      @next_units.concat( joined_el.count.times.collect{ |u| new_el.count + (u * 2) } ) # на каждое 2ое место встанет 1

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
