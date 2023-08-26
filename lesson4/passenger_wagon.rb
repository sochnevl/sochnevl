class PassengerWagon < Wagon
  attr_reader :type

  def initialize
    @type = 'пассажирский'
  end
end
