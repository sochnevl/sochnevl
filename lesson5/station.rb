require_relative 'instance_counter'

class Station
  include InstanceCounter
  # Может возвращать список всех поездов на станции, находящиеся в текущий момент
  attr_reader :name, :trains

  @@all_stations = []
  
  # метод класса для просмотра созданных поездов
  def self.all
    @@all_stations
  end

  def initialize(name)
    @name = name
    @trains = []
    @@all_stations << self
    register_instance
  end

  # Может принимать поезда.
  def add_train(train)
    @trains << train
  end

  # Может возвращать список поездов на станции по типу.
  def trains_by_type(type)
    @trains.select { |train| train.type == type }
  end

  # Может отправлять поезда.
  def send_train(train)
    @trains.delete(train)
  end
end
