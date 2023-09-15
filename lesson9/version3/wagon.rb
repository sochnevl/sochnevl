# frozen_string_literal: true

require_relative 'company_name'
require_relative 'accessors'
require_relative 'validation'

class Wagon
  include ManufacturerCompany
  include Accessors
  include Validation
  attr_reader :type, :used_place

  attr_accessor_with_history :total_place
  strong_attr_accessor :type, Symbol

  validate :type, :type, Symbol
  validate :total_place, :type, Integer

  def initialize(total_place, type)
    @total_place = total_place
    @type = type
    @used_place = 0
    validate!
  end

  def free_place
    @total_place - @used_place
  end
end

# -------------------------------------------
# Пример использования:
# wagon = Wagon.new(10, :passenger)
# puts wagon.valid?
# # Вернет true, экземпляр успешно создан

# wagon.total_place = 50
# train.total_place = 60
# train.total_place_history
# Выведет массив истории кол-ва мест

# wagon = Train.new("1", 'cargo')
# выдаст ошибки валидации
