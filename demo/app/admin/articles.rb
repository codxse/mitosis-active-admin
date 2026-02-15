ActiveAdmin.register Article do
  permit_params :title, :body

  form do |f|
    f.inputs do
      f.input :title
      f.input :body, as: :mitosis_editor,
        editor_options: { height: "400px", placeholder: "Write your article in markdown..." }
    end
    f.actions
  end
end
