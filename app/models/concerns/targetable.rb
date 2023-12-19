module Targetable
  extend ActiveSupport::Concern

  # Returns the characteristics of the targetable object.
  def characteristics
    self.class::TARGETABLE_CHARACTERISTICS
  end

  class << self
    # Returns an array of target types that include the Targetable module.
    def included(base)
      @target_types = ObjectSpace.each_object(Class).select { |klass| klass.included_modules.include?(self) }
    end

    attr_reader :target_types
  end
end
