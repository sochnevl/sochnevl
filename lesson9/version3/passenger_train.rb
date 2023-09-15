# frozen_string_literal: true

class PassengerTrain < Train

  validate :number, :presence
  validate :number, :format, NUMBER_FORMAT
  validate :type, :type, Symbol

  def initialize(number, type = :passenger, wagons = [])
    super
  end
end
