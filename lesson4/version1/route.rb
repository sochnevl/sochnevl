class Route
  # Может выводить список всех станций по-порядку от начальной до конечной.
  attr_reader :stations

  # Имеет начальную и конечную станцию.
  def initialize (first_station, last_station)
  	@stations = [first_station, last_station]
  end

  # Может добавить промежуточные станции.
  def add_station(station)
    @stations.insert(-2, station)
  end
  
  # Может удалять промежуточную станцию из списка.
  def delete_station(station)
    @stations.delete(station) if station != @stations.first && station != @stations.last
  end
end
