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
          # Если есть повторения, то обрабатываем их
          repeat_index = @current_repeats.shift

          if repeat_index >= i

            repeat_el = el[repeat_index]

            # Обрабатываем интервал от [i .. repeat_index] - там нет повторений
            arr.concat(only_units(el, arr, i, i = repeat_index)) if i != repeat_index

            # Ищем количество повторов
            count = find_repeat_count(el, i, repeat_el)

            # Если количество поторов == последний элемент в текущем результате, то добавляем в массив повторов
            @next_repeats << arr.count - 1 if arr.last == count.to_s

            # Добавляем в результирующий массив
            arr.concat([ count.to_s, repeat_el ])

            # Если количество повторов == повторяющийся элемент
            @next_repeats << arr.count - 2 if repeat_el == count.to_s

            # Если повторяющийся элемент еденица
            @next_units   << arr.count - 1 if repeat_el == '1'

            i += count
          end
        else
          # Обрабатываем "хвост", там не повторов
          arr.concat(only_units(el, arr, i, i = el.count))
        end
      end
    end
  end

  # [2, 3, 4, 1] => [1, 2, 1, 3, 1, 4, 1, 1]
  def only_units(el, new_el, i_current, i_next)
    # Кусок в котором нет повторов
    joined_el = el[i_current ... i_next]

    # Новый кусок с еденицами м\у элементов
    result = "1#{ joined_el.join('1') }".split('')

    # Узнаем есть ли в текущем куске joined_el еденицы => вернет массив координат
    repeat_units = @current_units.select{ |u| u < i_next && u >= i_current } # значит в куске el есть единицы

    # Поскольку в result первая стоит 1, то есть вариант, что в текущем результате последняя == 1, значит повторо
    @next_repeats << new_el.count - 1 if new_el.last == '1'

    # Если нашли еденицы в joined_el, то конвертируем координаты из системы счисления старого елемента (el), в новый (new_el)
    if repeat_units.any?
      @next_repeats.concat(repeat_units.map{ |u| new_el.count +  (u - i_current) * 2 })
    end

    # Добавляем в массив едениц нечетные координаты joined_el, потому что там еденицы
    @next_units.concat( joined_el.count.times.collect{ |u| new_el.count + (u * 2) } )

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
