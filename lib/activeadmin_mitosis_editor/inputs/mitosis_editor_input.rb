require "formtastic/inputs/string_input"

module ActiveAdminMitosisEditor
  module Inputs
    class MitosisEditorInput < Formtastic::Inputs::StringInput
      def to_html
        input_wrapping do
          builder.hidden_field(method, input_html_options) +
          template.render("inputs/mitosis_editor_input/form", { builder: builder, method: method, input_html_options: input_html_options })
        end
      end

      def input_html_options
        super.merge(class: "mitosis-editor-input hidden", data: { mit_height: options[:height] || "500px", mit_placeholder: options[:placeholder] || "" })
      end
    end
  end
end
