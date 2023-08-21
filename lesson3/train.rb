class Train
  attr_accessor :speed # Может набирать скорость, Может возвращать текущую скорость
  attr_reader :numbers_of_wagons # Может возвращать количество вагонов
  attr_reader :type
  
  def initialize(number, type, numbers_of_wagons) # Имеет номер (произвольная строка) и тип (грузовой, пассажирский) и количество вагонов, эти данные указываются при создании экземпляра класса
  	@number = number
  	@type = type.downcase
  	@numbers_of_wagons = numbers_of_wagons
    @array_of_train_station = nil
    @current_station_index = 0
    @speed = 0
  end

  def stop # Может тормозить (сбрасывать скорость до нуля)
  	@speed = 0
  end

  def attach_a_wagon
  	if @speed == 0
  	  @numbers_of_wagons += 1
    else
      puts "Сперва остановите поезд!"
  	end
  end

  def unhook_the_wagon # Может прицеплять/отцеплять вагоны (по одному вагону за операцию, метод просто увеличивает или уменьшает количество вагонов). Прицепка/отцепка вагонов может осуществляться только если поезд не движется.
  	if @speed == 0
  	  @numbers_of_wagons -= 1
    else
      puts "Сперва остановите поезд!"
  	end
  end

  def add_route(route) # Может принимать маршрут следования (объект класса Route). При назначении маршрута поезду, поезд автоматически помещается на первую станцию в маршруте.
    @array_of_train_station = route.stations
    puts "Поезд прибыл на первую станцию #{@array_of_train_station[@current_station_index]}" 
  end

  def next_station # Может перемещаться между станциями, указанными в маршруте. Перемещение возможно вперед и назад, но только на 1 станцию за раз.
    @current_station_index += 1
    puts "Поезд прибыл на станцию #{@array_of_train_station[@current_station_index]}"
  end
  
  def previous_station
    @current_station_index -= 1
    puts "Поезд вернулся на станцию #{@array_of_train_station[@current_station_index]}"
  end

  def info_stations # Возвращать предыдущую станцию, текущую, следующую, на основе маршрута
    puts "Текущая станция: #{@array_of_train_station[@current_station_index]}"
    puts "Предыдущая станция: #{@array_of_train_station[@current_station_index - 1]}"
    puts "Следующая станция: #{@array_of_train_station[@current_station_index + 1]}"
  end
end