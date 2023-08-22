class Train
  # Может: набирать скорость, возвращать текущую скорость, возвращать количество вагонов, возвращать текущую станцию.
  attr_accessor :speed
  attr_reader :number, :type, :numbers_of_wagons, :current_station
  # Имеет номер, тип (грузовой, пассажирский) и количество вагонов.
  def initialize(number, type, numbers_of_wagons)
    @number = number
    @type = type.downcase
    @numbers_of_wagons = numbers_of_wagons
    @speed = 0
  end
  # Может тормозить (сбрасывать скорость до нуля).
  def stop
    @speed = 0
  end
  # Может прицеплять/отцеплять вагоны. Прицепка/отцепка вагонов может осуществляться только если поезд не движется.
  def attach_a_wagon
    @numbers_of_wagons += 1 if @speed == 0
  end

  def unhook_the_wagon
    @numbers_of_wagons -= 1 if @speed == 0 && @numbers_of_wagons > 0
  end
  # Может принимать маршрут следования. При назначении маршрута поезду, поезд автоматически помещается на первую станцию в маршруте.
  def add_route(route)
    @route = route
    @current_station = route.stations.first
    @current_station.add_train(self)
  end
  # Может перемещаться между станциями, указанными в маршруте.
  def move_forward
    return unless next_station

    @current_station.send_train(self)
    @current_station = next_station
    @current_station.add_train(self)
  end

  def move_backward
    return unless previous_station

    @current_station.send_train(self)
    @current_station = previous_station
    @current_station.add_train(self)
  end
  # Может возвращать следующую станцию.
  def next_station
    return unless @route

    current_index = @route.stations.index(@current_station)
    @route.stations[current_index + 1] if current_index < @route.stations.size - 1
  end
  # Может возвращать предыдущую станцию.
  def previous_station
    return unless @route

    current_index = @route.stations.index(@current_station)
    @route.stations[current_index - 1] if current_index.positive?
  end
end
