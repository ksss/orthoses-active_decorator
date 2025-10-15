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
          model_name = decorator_name.delete_suffix(decorator_suffix)
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

    def decorator_suffix
      ::ActiveDecorator.config.decorator_suffix
    end

    def decorator_modules
      app_decorators_path = ::Rails.root.join("app/decorators").to_s
      ObjectSpace.each_object(Module).select do |mod|
        name = Orthoses::Utils.module_name(mod) or next
        next unless name.end_with?(decorator_suffix)

        path, _line = Object.const_source_location(name)
        next unless path&.start_with?(app_decorators_path)
        next if Class === mod

        mod
      end
    end
  end
end
