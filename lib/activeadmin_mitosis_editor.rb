require "activeadmin_mitosis_editor/version"
require "activeadmin_mitosis_editor/railtie" if defined?(Rails)

module ActiveAdminMitosisEditor
  module Inputs
    autoload :MitosisEditorInput, "activeadmin_mitosis_editor/inputs/mitosis_editor_input"
  end
end
