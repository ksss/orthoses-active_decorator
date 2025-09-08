# frozen_string_literal: true

require_relative "lib/orthoses/active_decorator/version"

Gem::Specification.new do |spec|
  spec.name = "orthoses-active_decorator"
  spec.version = Orthoses::ActiveDecorator::VERSION
  spec.authors = ["ksss"]
  spec.email = ["co000ri@gmail.com"]

  spec.summary = "Orthoses middleware for active_decorator"
  spec.description = "Orthoses middleware for active_decorator"
  spec.homepage = "https://github.com/ksss/orthoses-active_decorator"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 3.2.0"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = spec.homepage
  spec.metadata["changelog_uri"] = spec.homepage
  spec.metadata["rubygems_mfa_required"] = "true"

  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    [
      %w[CHANGELOG.md CODE_OF_CONDUCT.md LICENSE.txt README.md],
      Dir.glob("lib/**/*.*").grep_v(/_test\.rb\z/)
    ].flatten
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "active_decorator"
  spec.add_dependency "orthoses", ">= 1.13"
end
