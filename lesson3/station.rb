class Station
  # Может возвращать список всех поездов на станции, находящиеся в текущий момент
  attr_reader :name, :trains

  def initialize(name)
    @name = name
    @trains = []
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
