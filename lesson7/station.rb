require_relative 'instance_counter'
require_relative 'validation'

class Station
  include InstanceCounter
  include Validation

  attr_reader :name, :trains

  @@all_stations = []

  def self.all
    @@all_stations
  end

  def initialize(name)
    @name = name
    @trains = []
    validate!
    @@all_stations << self
    register_instance
  end

  def add_train(train)
    @trains << train
  end

  def trains_by_type(type)
    @trains.select { |train| train.type == type }
  end

  # Может отправлять поезда.
  def send_train(train)
    @trains.delete(train)
  end

  def each_trains(&block)
    @trains.each(&block)
  end

  protected

  def validate!
    raise "Вы не ввели название станции!" if name.nil?
  end
end
