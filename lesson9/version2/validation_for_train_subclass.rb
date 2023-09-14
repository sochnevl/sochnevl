# frozen_string_literal: true

module ValidationTrainSubclass
  NUMBER_FORMAT = /^\w{3}-?\w{2}$/i.freeze

  def valid?
    validate!
    true
  rescue StandardError
    false
  end

  protected

  def validate!
    errors = []
    errors << 'number cannot be nil' if number_nil_error?
    errors << 'number format is invalid' if invalid_number_format?
    errors << 'type is invalid' unless valid_train_type?
    errors << 'value of wagons cannot be nil' if wagons_nil_error?
    raise errors.join('. ') unless errors.empty?
  end

  def number_nil_error?
    number.nil?
  end

  def invalid_number_format?
    number !~ NUMBER_FORMAT
  end

  def valid_train_type?
    type == :cargo || type == :passenger
  end

  def wagons_nil_error?
    wagons.nil?
  end
end
