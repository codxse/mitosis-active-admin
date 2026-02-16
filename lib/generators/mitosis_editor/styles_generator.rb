require "rails/generators"

module MitosisEditor
  class StylesGenerator < Rails::Generators::Base
    source_root File.expand_path("../../../vendor/assets/stylesheets", __dir__)

    desc "Copy CSS files for customization"

    def copy_css_files
      copy_file "mitosis-editor.css",
        "app/assets/stylesheets/mitosis_editor/mitosis-editor.css"
      copy_file "theme-light.min.css",
        "app/assets/stylesheets/mitosis_editor/theme-light.css"
      copy_file "theme-dark.min.css",
        "app/assets/stylesheets/mitosis_editor/theme-dark.css"
    end

    def show_readme
      puts "\nDone! CSS files copied to app/assets/stylesheets/mitosis_editor/"
      puts "You can customize the CSS variables in these files."
      puts "Then update your dependencies to use your custom CSS:"
      puts "  <%= stylesheet_link_tag 'mitosis_editor/mitosis-editor' %>"
    end
  end
end
