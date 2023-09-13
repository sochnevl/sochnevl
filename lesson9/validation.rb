# frozen_string_literal: true

module Validation
  def self.included(base)
    base.extend(ClassMethods)
    base.send :include, InstanceMethods
  end

  module ClassMethods
    def validate(name, validation_type, *args)
      @validations ||= []
      @validations << { name: name.to_sym, type: validation_type, args: args }
    end

    def validations
      @validations || []
    end
  end

  module InstanceMethods
    def validate!
      self.class.validations.each do |validation|
        name = validation[:name]
        type = validation[:type]
        args = validation[:args]

        send("validate_#{type}", name, *args)
      end
    end

    def valid?
      validate!
      true
    rescue StandardError
      false
    end

    private

    def validate_presence(name)
      value = instance_variable_get("@#{name}".to_sym)
      raise "#{name} cannot be nil or empty" if value.nil? || (value.respond_to?(:empty?) && value.empty?)
    end

    def validate_format(name, format)
      value = instance_variable_get("@#{name}".to_sym)
      raise "#{name} format is invalid" unless value =~ format
    end

    def validate_type(name, type)
      value = instance_variable_get("@#{name}".to_sym)
      raise "#{name} is not an instance of #{type}" unless value.is_a?(type)
    end
  end
end
