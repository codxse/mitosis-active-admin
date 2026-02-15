require "formtastic/inputs/string_input"

module ActiveAdminMitosisEditor
  module Inputs
    class MitosisEditorInput < Formtastic::Inputs::StringInput
      def to_html
        input_wrapping do
          builder.hidden_field(method, input_html_options) +
          template.render("inputs/mitosis_editor_input/form", {
            builder: builder,
            method: method,
            input_html_options: input_html_options,
            editor_options_json: editor_options.to_json
          })
        end
      end

      def input_html_options
        super.merge(class: "mitosis-editor-input hidden")
      end

      private

      def editor_options
        { height: "500px", placeholder: "" }.merge(options[:editor_options] || {})
      end
    end
  end
end
