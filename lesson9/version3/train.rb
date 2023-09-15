# frozen_string_literal: true

require_relative 'company_name'
require_relative 'instance_counter'
require_relative 'accessors'
require_relative 'validation'

class Train
  include ManufacturerCompany
  include InstanceCounter
  include Accessors
  include Validation

  attr_reader :number, :type, :wagons, :current_station, :route

  NUMBER_FORMAT = /^\w{3}-?\w{2}$/i.freeze

  attr_accessor_with_history :speed
  strong_attr_accessor :name, String

  validate :number, :presence
  validate :number, :format, NUMBER_FORMAT
  validate :type, :type, Symbol
  validate :wagons, :presence

  def initialize(number, type, wagons)
    @number = number
    @type = type.downcase
    @wagons = wagons
    validate!
    @speed = 0
    include_train
    register_instance
  end

  def stop
    @speed = 0
  end

  def attach_a_wagon(wagon)
    @wagons << wagon if @speed.zero? && wagon.type == type
  end

  def unhook_the_wagon
    @wagons.delete_at(-1) if @speed.zero? && @wagons.size.positive?
  end

  def add_route(route)
    @route = route
    @current_station = route.stations.first
    @current_station.add_train(self)
  end

  def move_forward
    move_forward! if @speed.positive?
    stop
  end

  def move_backward
    move_backward! if @speed.positive?
    stop
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

  def each_wagons(&block)
    @wagons.each(&block)
  end

  protected

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

# -------------------------------------------
# Пример использования:
# train = Train.new('abc-12', :passenger, 5)
# puts my_train.valid?
# # Вернет true, экземпляр успешно создан

# train.speed = 50
# train.speed = 60
# train.speed_history
# Выведет массив истории изменений скорости

# invalid_station = Station.new('station B')
# Выбросит исключение


