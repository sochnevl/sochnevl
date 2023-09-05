class CargoWagon < Wagon
  attr_reader :total_volume, :filled_volume

  def initialize(type = :cargo, total_volume)
    super(type)
    @total_volume = total_volume
    @filled_volume = 0
  end

  def fill_volume(volume)
    @filled_volume += volume if volume <= free_volume
  end

  def free_volume
    @total_volume - @filled_volume
  end
end
