class Station
  attr_reader :trains # Может возвращать список всех поездов на станции, находящиеся в текущий момент

  def initialize(name) #Имеет название, которое указывается при ее создании
  	@name = name
  	@trains = []
  	@freight_train_counter = 0
  	@passenger_train_counter = 0
  end
  
  def add_train(train) # Может принимать поезда (по одному за раз)
  	@trains << train
  	if train.type == "грузовой"
  	  @freight_train_counter += 1
  	else
  	  @passenger_train_counter += 1
  	end
  end

  def train_on_station_info #Может возвращать список поездов на станции по типу (см. ниже): кол-во грузовых, пассажирских
    puts "Грузовых поездов на станции: #{@freight_train_counter}"
    puts "Пассажирских поездов на станции: #{@passenger_train_counter}"
  end

  def send_train(train) # Может отправлять поезда (по одному за раз, при этом, поезд удаляется из списка поездов, находящихся на станции).
    @trains.delete(train)
  end
end