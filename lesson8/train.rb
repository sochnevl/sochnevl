# frozen_string_literal: true

require_relative 'company_name'
require_relative 'instance_counter'
require_relative 'validation'

class Train
  include ManufacturerCompany
  include InstanceCounter
  include Validation

  attr_accessor :speed
  attr_reader :number, :type, :wagons, :current_station

  NUMBER_FORMAT = /^\w{3}-?\w{2}$/i.freeze

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

  def validate!
    errors = []
    errors << 'Номер поезда не может быть nil' if number_nil_error?
    errors << 'Неверный формат номера' if invalid_number_format?
    errors << 'Не верный тип создаваемого поезда' unless valid_train_type?
    errors << 'Значение wagons не может быть nil' if wagons_nil_error?
    raise errors.join('. ') unless errors.empty?
  end

  def number_nil_error?
    number.nil?
  end

  def invalid_number_format?
    number !~ NUMBER_FORMAT
  end

  def valid_train_type?
    type == :cargo || type == :passenger
  end

  def wagons_nil_error?
    wagons.nil?
  end
end
