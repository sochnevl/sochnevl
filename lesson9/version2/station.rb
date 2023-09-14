# frozen_string_literal: true

require_relative 'instance_counter'
require_relative 'accessors'
require_relative 'validation'

class Station
  include InstanceCounter
  include Accessors
  include Validation

  attr_reader :trains

  NAME_FORMAT = /^[A-Z][a-z]+$/i.freeze

  attr_accessor_with_history :name

  validate :name, :presence
  validate :name, :format, NAME_FORMAT

  @all_stations = []

  def self.all
    @all_stations
  end

  def initialize(name)
    @name = name
    @trains = []
    validate!
    self.class.all << self
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
end

# -------------------------------------------
# Пример использования:
# station = Station.new('Station A')
# puts wagon.valid?
# # Вернет true, экземпляр успешно создан

# station.name = 'Station B'
# station.name = 'Station C'
# puts station.name_history
# Выведет массив истории имен

# wagon.total_place = 50
# train.total_place = 60
# train.total_place_history # вернет массив [50, 60]

# wagon = Train.new("1", 'cargo')
# выдаст ошибки валидации
