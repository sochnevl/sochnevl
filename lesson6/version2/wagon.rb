require_relative 'company_name'

class Wagon
  include ManufacturerCompany
  attr_reader :type

  def initialize(type)
    @type = type
    validate!
  end

  def valid?
    validate!
    true # true если validate! не выбросил исключение
  rescue
    false # false , если validate! выбросил исключение
  end

  protected

  def validate!
    raise "Не верный тип создаваемого вагона!" if type != :cargo && type != :passenger
  end
end
