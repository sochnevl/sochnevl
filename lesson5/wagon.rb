require_relative 'company_name'

class Wagon
  # подключение модулей для просмотра и назнаечния компаний
  include ManufacturerCompany
  attr_reader :type
end
