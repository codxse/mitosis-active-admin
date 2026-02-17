require_relative "lib/activeadmin_mitosis_editor/version"

Gem::Specification.new do |spec|
  spec.name          = "activeadmin_mitosis_editor"
  spec.version       = ActiveAdminMitosisEditor::VERSION
  spec.authors       = ["Nadiar"]
  spec.email         = ["codex@nadiar.id"]
  spec.summary       = "A split-view markdown editor input for ActiveAdmin"
  spec.description   = "Wraps mitosis-js as a custom input for ActiveAdmin forms"
  spec.license       = "MIT"
  spec.homepage      = "https://github.com/codxse/mitosis-active-admin"
  spec.metadata["source_code_uri"] = "https://github.com/codxse/mitosis-active-admin"
  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(spec|\.git)}) }
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "railties", ">= 6.0"
  spec.add_runtime_dependency "formtastic", ">= 4.0"
  spec.add_runtime_dependency "activesupport", ">= 6.0"
end
