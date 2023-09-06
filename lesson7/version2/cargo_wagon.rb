class CargoWagon < Wagon

  def initialize(type = :cargo, total_place)
    super
  end

  def take_volume(volume)
    @used_place += volume if free_place >= volume
  end
end
