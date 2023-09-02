require_relative 'instance_counter'

class Station
  include InstanceCounter

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

  def valid?
    validate!
    true # true если validate! не выбросил исключение
  rescue
    false # false , если validate! выбросил исключение
  end

  protected

  def validate!
    raise "Вы не ввели название станции!" if name.nil?
  end
end
