module ActiveAdminMitosisEditor
  class Engine < Rails::Engine
    # Add gem assets to the asset pipeline
    # App assets take precedence - gem assets are added at the END
    # so Rails finds app's version first (if it exists)
    initializer "activeadmin_mitosis_editor.assets" do
      Rails.application.config.assets.paths <<
        root.join("vendor/assets/stylesheets").to_s
      Rails.application.config.assets.paths <<
        root.join("vendor/assets/javascripts").to_s
    end

    initializer "activeadmin_mitosis_editor.formtastic_custom_inputs" do
      require "activeadmin_mitosis_editor/inputs/mitosis_editor_input"

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

      Formtastic::Inputs::MitosisEditorInput = ActiveAdminMitosisEditor::Inputs::MitosisEditorInput
    end
  end
end
