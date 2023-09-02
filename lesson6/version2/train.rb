require_relative 'company_name'
require_relative 'instance_counter'

class Train
  include ManufacturerCompany
  include InstanceCounter

  attr_accessor :speed
  attr_reader :number, :type, :wagons, :current_station

  NUMBER_FORMAT = /^[\w]{3}-?[\w]{2}$/i

  @@all_trains =[]

  def self.find(number)
    @@all_trains.find {|train| train.number == number}
  end

  def initialize(number, type, wagons)
    @number = number
    @type = type.downcase
    @wagons = wagons
    validate!
    @speed = 0
    @@all_trains << self
    register_instance
  end

  def stop
    @speed = 0
  end

  def attach_a_wagon(wagon)
    @wagons << wagon if @speed == 0 && wagon.type == type
  end

  def unhook_the_wagon
    @wagons.delete_at(-1) if @speed == 0 && @wagons.size > 0
  end

  def add_route(route)
    @route = route
    @current_station = route.stations.first
    @current_station.add_train(self)
  end

  def move_forward
    move_forward! if @speed > 0
    self.stop
  end

  def move_backward
    move_backward! if @speed > 0
    self.stop
  end

  def next_station
    return unless @route

    current_index = @route.stations.index(@current_station)
    @route.stations[current_index + 1] if current_index < @route.stations.size - 1
  end

  def previous_station
    return unless @route

    current_index = @route.stations.index(@current_station)
    @route.stations[current_index - 1] if current_index.positive?
  end

  def valid?
    validate!
    true # true если validate! не выбросил исключение
  rescue
    false # false , если validate! выбросил исключение
  end

  protected

  def validate!
    errors = []
    errors << "Номер поезда не может быть nil" if number.nil?
    errors << "Неверный формат номера" if number !~ NUMBER_FORMAT
    errors << "Не верный тип создаваемого поезда" unless type == :cargo || type == :passenger
    errors << "Значение wagons не может быть nil" if wagons.nil?
    raise errors.join(". ") unless errors.empty?
  end

  def move_forward!
    return unless next_station

    @current_station.send_train(self)
    @current_station = next_station
    @current_station.add_train(self)
  end

  def move_backward!
    return unless previous_station

    @current_station.send_train(self)
    @current_station = previous_station
    @current_station.add_train(self)
  end
end
