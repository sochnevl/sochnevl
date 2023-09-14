# frozen_string_literal: true

module Accessors
  def self.included(base)
    base.extend(ClassMethods)
  end

  module ClassMethods
    def attr_accessor_with_history(*names)
      names.each do |name|
        var_name = "@#{name}".to_sym
        history_name = "@#{name}_history".to_sym

        define_method(name) { instance_variable_get(var_name) }

        define_method("#{name}=") do |value|
          instance_variable_set(var_name, value)
          history = instance_variable_get(history_name) || []
          history << value
          instance_variable_set(history_name, history)
        end

        define_method("#{name}_history") { instance_variable_get(history_name) }
      end
    end

    def strong_attr_accessor(name, type)
      var_name = "@#{name}".to_sym

      define_method(name) { instance_variable_get(var_name) }

      define_method("#{name}=") do |value|
        raise "Invalid type, expected #{type}" unless value.is_a?(type)

        instance_variable_set(var_name, value)
      end
    end
  end
end
