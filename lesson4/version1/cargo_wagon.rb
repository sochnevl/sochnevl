class CargoWagon < Wagon
  attr_reader :type

  def initialize
    @type = 'грузовой'
  end
end
