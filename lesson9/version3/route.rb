# frozen_string_literal: true

require_relative 'instance_counter'
require_relative 'accessors'
require_relative 'validation'

class Route
  include InstanceCounter
  include Accessors
  include Validation

  strong_attr_accessor :first_station, Station
  strong_attr_accessor :last_station, Station
  attr_accessor_with_history :stations

  validate :first_station, :presence
  validate :last_station, :presence
  validate :first_station, :type, Station
  validate :last_station, :type, Station

  def initialize(first_station, last_station)
    @first_station = first_station
    @last_station = last_station
    @stations = [first_station, last_station]
    validate!
    register_instance
  end

  def add_station(station)
    @stations.insert(-2, station)
  end

  def delete_station(station)
    @stations.delete(station) if station != @stations.first && station != @stations.last
  end
end
