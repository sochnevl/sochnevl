module ValidationWagonSubclass

  def valid?
    validate!
    true
  rescue StandardError
    false
  end

  protected

  def validate!
    errors = []
    errors << 'wagon type is invalid!' if type != :cargo && type != :passenger
    errors << 'total_place must be integer' unless total_place.is_a?(Integer)
    raise errors.join('. ') unless errors.empty?
  end
end
