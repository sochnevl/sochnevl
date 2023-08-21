class Route
  attr_reader :start_of_route
  attr_reader :end_of_route

  def initialize (start_of_route, end_of_route) # Имеет начальную и конечную станцию
  	@start_of_route = start_of_route
  	@end_of_route = end_of_route
  	@route = [start_of_route, end_of_route]
  end

  def add_station(station) # Начальная и конечная станции указываютсся при создании маршрута, а промежуточные могут добавляться между ними
    @route.insert(-2, station)
  end

  def delete_station(station) # Может удалять промежуточную станцию из списка
    @route.delete(station)
  end

  def stations
    @route
  end

  def show_the_route # Может выводить список всех станций по-порядку от начальной до конечной
    @route.each do |stations|
      puts stations
    end
  end
end