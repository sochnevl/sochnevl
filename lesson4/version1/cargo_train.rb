class CargoTrain < Train
  def initialize(number, type = 'грузовой', wagons = [])
    super
  end

  def attach_a_wagon(wagon)
    @wagons << wagon if @speed == 0 && wagon.is_a?(CargoWagon)
  end

  def unhook_the_wagon
    @wagons.delete_at(-1) if @speed == 0 && @wagons.size > 0
  end
end
