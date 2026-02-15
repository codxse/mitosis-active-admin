module ActiveAdminMitosisEditor
  class Railtie < Rails::Railtie
    initializer "activeadmin_mitosis_editor.assets" do
      if defined?(Sprockets)
        Rails.application.config.assets.paths << root.join("vendor/assets/javascripts").to_s
        Rails.application.config.assets.paths << root.join("vendor/assets/stylesheets").to_s
      end
    end
  end
end
