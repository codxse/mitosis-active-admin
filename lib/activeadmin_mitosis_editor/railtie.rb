module ActiveAdminMitosisEditor
  class Engine < Rails::Engine
    # Asset paths are not registered via Railtie to avoid conflicts with app-level
    # asset overrides. Applications using this gem should copy the bundled assets
    # from vendor/assets to their app/assets/stylesheets/mitosis_editor/ directory.
  end
end
