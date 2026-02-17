require "rails/generators"

module MitosisEditor
  class StylesGenerator < Rails::Generators::Base
    source_root File.expand_path("../../../vendor/assets/stylesheets", __dir__)

    desc "Copy CSS files for customization"

    def copy_css_files
      copy_file "mitosis-editor.css",
        "app/assets/stylesheets/mitosis-editor.css"
      copy_file "theme-light.css",
        "app/assets/stylesheets/theme-light.css"
      copy_file "theme-dark.css",
        "app/assets/stylesheets/theme-dark.css"
    end

    def show_readme
      puts "\nDone! CSS files copied to app/assets/stylesheets/"
      puts "You can customize the CSS variables in these files."
    end
  end
end
