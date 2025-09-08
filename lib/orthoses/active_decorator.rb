# frozen_string_literal: true

require_relative "active_decorator/version"

module Orthoses
  class ActiveDecorator
    def initialize(loader)
      @loader = loader
    end

    def call
      @loader.call.tap do |store|
        decorator_modules.each do |mod|
          decorator_name = mod.name
          model_name = mod.name.sub("Decorator", "")
          begin
            model_name.constantize
          rescue NameError
            next
          end
          store[decorator_name].header = "module #{decorator_name} : #{model_name}"
        end
      end
    end

    private

    def decorator_modules
      ObjectSpace.each_object(Module).select do |mod|
        name = Orthoses::Utils.module_name(mod) or next
        next unless name.end_with?("Decorator")

        path, _line = Object.const_source_location(name)
        next unless path&.start_with?(::Rails.root.join("app/decorators").to_s)

        mod
      end
    end
  end
end
