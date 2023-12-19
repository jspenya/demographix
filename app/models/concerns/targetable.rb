module Targetable
  extend ActiveSupport::Concern

  def characteristics
    self.class::TARGETABLE_CHARACTERISTICS
  end

  class << self
    def included(base)
      @target_types = ObjectSpace.each_object(Class).select { |klass| klass.included_modules.include?(self) }
    end

    attr_reader :target_types
  end
end
