require_relative 'company_name'
require_relative 'validation'

class Wagon
  include ManufacturerCompany
  include Validation
  attr_reader :type

  def initialize(type)
    @type = type
    validate!
  end

  protected

  def validate!
    raise "Не верный тип создаваемого вагона!" if type != :cargo && type != :passenger
  end
end
