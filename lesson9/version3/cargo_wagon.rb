# frozen_string_literal: true

class CargoWagon < Wagon
  def initialize(total_place, type = :cargo)
    super
  end

  def take_volume(volume)
    @used_place += volume if free_place >= volume
  end
end
