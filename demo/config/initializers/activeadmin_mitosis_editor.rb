# Require the gem's input
require "activeadmin_mitosis_editor"

# Register custom input with Formtastic
Formtastic::Inputs.send(:include, Module.new do
  def self.included(base)
    base.extend(ClassMethods)
  end

  module ClassMethods
    def custom_input_class(name, class_name)
      @custom_input_classes ||= {}
      @custom_input_classes[name.to_sym] = class_name
    end
  end
end)

# Make sure the input is loaded and available
Formtastic::Inputs::MitosisEditorInput = ActiveAdminMitosisEditor::Inputs::MitosisEditorInput
