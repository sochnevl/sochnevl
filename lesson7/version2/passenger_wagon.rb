class PassengerWagon < Wagon

  def initialize(type = :passenger, total_place)
    super
  end

  def take_seat
    @used_place += 1 if free_place > 0
  end
end
