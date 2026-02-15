# Load the Rails application.
require_relative "application"

# Monkey patch for Rails 8 compatibility with ActiveAdmin 4.x
unless ActiveSupport::Deprecation.respond_to?(:silence)
  class ActiveSupport::Deprecation
    def self.silence
      @silenced = true
      yield
    ensure
      @silenced = false
    end

    def silenced?
      @silenced
    end
  end
end

# Initialize the Rails application.
Rails.application.initialize!
