class PassengerTrain < Train
  def initialize(number, type = 'пассажирский', wagons = [])
    super
  end

  def attach_a_wagon(wagon)
    @wagons << wagon if @speed == 0 && wagon.is_a?(PassengerWagon)
  end

  def unhook_the_wagon
    @wagons.delete_at(-1) if @speed == 0 && @wagons.size > 0
  end
end
