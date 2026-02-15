require "rails/generators"

module MitosisEditor
  class ViewsGenerator < Rails::Generators::Base
    source_root File.expand_path("templates", __dir__)

    desc "Copy mitosis editor dependencies partial for customization"

    def copy_dependencies_partial
      copy_file "_dependencies.html.erb",
        "app/views/inputs/mitosis_editor_input/_dependencies.html.erb"
    end
  end
end
