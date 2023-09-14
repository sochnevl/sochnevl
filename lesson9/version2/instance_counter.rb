# frozen_string_literal: true

module InstanceCounter
  def self.included(base)
    base.extend ClassMethods
    base.include InstanceMethods
  end

  module ClassMethods
    attr_accessor :instances, :all_trains

    def find(number)
      @all_trains.find { |train| train.number == number }
    end
  end

  module InstanceMethods
    protected

    def register_instance
      self.class.instances ||= 0
      self.class.instances += 1
    end

    def include_train
      self.class.all_trains ||= []
      self.class.all_trains << self
    end
  end
end
