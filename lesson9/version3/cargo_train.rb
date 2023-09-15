# frozen_string_literal: true

class CargoTrain < Train

  validate :number, :presence
  validate :number, :format, NUMBER_FORMAT
  validate :type, :type, Symbol

  def initialize(number, type = :cargo, wagons = [])
    super
  end
end
