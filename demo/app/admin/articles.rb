ActiveAdmin.register Article do
  permit_params :title, :body

  form do |f|
    f.inputs do
      f.input :title
      f.input :body, as: :mitosis_editor, input_html: { class: "mitosis-editor-input" }
    end
    f.actions
  end
end
