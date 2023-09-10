# frozen_string_literal: true

require_relative 'company_name'
require_relative 'validation'

class Wagon
  include ManufacturerCompany
  include Validation
  attr_reader :type, :total_place, :used_place

  def initialize(total_place, type)
    @total_place = total_place
    @type = type
    @used_place = 0
    validate!
  end

  def free_place
    @total_place - @used_place
  end

  protected

  def validate!
    raise 'Не верный тип создаваемого вагона!' if type != :cargo && type != :passenger
  end
end
