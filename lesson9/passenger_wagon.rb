# frozen_string_literal: true

class PassengerWagon < Wagon
  def initialize(total_place, type = :passenger)
    super
  end

  def take_seat
    @used_place += 1 if free_place.positive?
  end
end
