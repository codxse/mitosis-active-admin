module ActiveAdminMitosisEditor
  class Engine < Rails::Engine
    initializer "activeadmin_mitosis_editor.assets" do
      Rails.application.config.assets.paths << ActiveAdminMitosisEditor.root.join("vendor/assets/javascripts").to_s
      Rails.application.config.assets.paths << ActiveAdminMitosisEditor.root.join("vendor/assets/stylesheets").to_s
    end
  end
end
