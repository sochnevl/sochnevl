class PassengerWagon < Wagon
  attr_reader :total_seats, :taken_seats

  def initialize(type = :passenger, total_seats)
    super(type)
    @total_seats = total_seats
    @taken_seats = 0
  end

  def take_seat
    @taken_seats += 1 if @taken_seats < @total_seats
  end

  def free_seats
    @total_seats - @taken_seats
  end
end
