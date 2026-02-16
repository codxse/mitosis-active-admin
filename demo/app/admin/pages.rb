ActiveAdmin.register Page do
  permit_params :title, :body

  form do |f|
    f.inputs do
      f.input :title
      f.input :body, as: :mitosis_editor,
        editor_options: { theme: "auto", height: "400px" }
    end
    f.actions
  end
end
