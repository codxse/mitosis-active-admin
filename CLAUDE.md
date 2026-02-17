# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is a Ruby gem called `activeadmin_mitosis_editor` that provides a split-view markdown editor input for ActiveAdmin forms. It wraps the mitosis-js library (a split-view markdown editor) as a Formtastic custom input type. The gem consists of:

1. **Main Gem** (`/lib`): The Ruby gem with Formtastic input class and Railtie for asset pipeline integration.
2. **Demo App** (`/demo`): A Rails 8.1 application demonstrating the gem's usage and system tests.
3. **Assets** (`/vendor/assets`): Pre-compiled mitosis-js and Prism syntax highlighter bundles. It downloaded from https://www.npmjs.com/package/@codxse/mitosis-js v1.6.0

- The gem integrates via Rails Railtie for automatic asset registration
- No database migrations required - stores markdown as plain strings
- All CSS/JS assets are pre-compiled and bundled for distribution
- Demo app uses modern Rails 8.1 with import maps and Tailwind CSS
- The editor is fully functional in both light and dark themes with automatic detection

## Architecture

### Gem Structure
- **`lib/activeadmin_mitosis_editor.rb`**: Main entry point defining the module and asset root
- **`lib/activeadmin_mitosis_editor/railtie.rb`**: Rails integration that registers gem assets with the asset pipeline
- **`lib/activeadmin_mitosis_editor/inputs/mitosis_editor_input.rb`**: Formtastic input class that extends `StringInput`
- **`app/views/inputs/mitosis_editor_input/_form.html.erb`**: Form partial rendering the editor container and initialization JavaScript
- **`app/views/inputs/mitosis_editor_input/_dependencies.html.erb`**: Partial for conditional stylesheet loading based on theme
- **`lib/generators/`**: Rails generators for users to customize CSS and dependencies

## File Organization

Key directories:
- `/lib`: Main gem code
- `/app/views`: View templates for the gem
- `/lib/generators`: Rails generators for customization
- `/vendor/assets`: Pre-built mitosis-js and Prism.js bundles
- `/demo`: Full Rails app demonstrating the gem
- `/demo/app/admin`: ActiveAdmin resource definitions for demo
- `/demo/spec`: RSpec test suite for the demo app

### Key Implementation Details
- The input stores markdown content in a hidden field
- JavaScript initialization happens inline in the form partial, using IIFE to avoid global scope pollution
- Theme support: 'light', 'dark', or 'auto' (auto detects via mutation observer on `<html>` class)
- Form submission captures editor content via `getMarkdown()` and writes to hidden field
- Optional Prism syntax highlighter auto-detection via `window.Prism`
- Assets loaded via Rails asset pipeline, with conditional theme stylesheets

### Data Flow
1. User registers editor via `f.input :field, as: :mitosis_editor` in ActiveAdmin form. Look at @demo/app/admin/articles.rb for example usage.
2. `MitosisEditorInput` renders the form partial with editor options
3. Form partial loads CSS/JS via `_dependencies` and initializes editor in a container div
4. Editor updates hidden field on form submit via `editor.getMarkdown()`
5. Rails saves the markdown string to the database as usual

## Common Development Tasks

### Setup Development Environment
```bash
# Install gem dependencies
bin/setup

# Set up and start demo app
cd demo
bundle install
npm install
bin/rails db:create db:migrate
```

### Running the Demo App
```bash
# From root directory
cd demo

# Start development server with CSS building
foreman start -f Procfile.dev

# Or run manually:
bin/rails server           # Port 3000
npm run build:css          # In another terminal
```

### Building and Testing the Gem
```bash
# From gem root directory

# Build the gem package
rake build

# Install the built gem locally
rake install

# Run demo app tests (must run from demo/ directory)
cd demo
bundle exec rspec

# Run specific spec file
bundle exec rspec spec/system/editor_spec.rb

# Run a single test
bundle exec rspec spec/system/editor_spec.rb:42
```

Note: RSpec is only available in the demo app, not in the gem root. The gem itself has no development dependencies; tests are integration tests in the demo Rails application.

### Updating Mitosis-JS Library

When updating the mitosis-js library in `/vendor/assets`:

1. Update the bundled files in `/vendor/assets/javascripts/` and `/vendor/assets/stylesheets/`
2. Sync the CSS files to `/demo/app/assets/stylesheets/mitosis_editor/` (this is where Rails reads them from):
   ```bash
   cp ../vendor/assets/stylesheets/mitosis-editor.css demo/app/assets/stylesheets/mitosis_editor/mitosis-editor.css
   cp ../vendor/assets/stylesheets/theme-dark.min.css demo/app/assets/stylesheets/mitosis_editor/theme-dark.css
   cp ../vendor/assets/stylesheets/theme-light.min.css demo/app/assets/stylesheets/mitosis_editor/theme-light.css
   ```
3. Clear caches in the demo app:
   ```bash
   cd demo
   rm -rf tmp/cache public/assets
   ```
4. Restart the Rails server
5. Clear browser cache or use incognito window to see the new assets

Note: The CSS files must be kept in `/demo/app/assets/stylesheets/mitosis_editor/` subdirectory, not the root stylesheets directory, as the asset pipeline will prefer files in the app's stylesheets folder over vendor/assets.

## Dependencies

### Runtime
- Rails >= 6.0
- Formtastic >= 4.0
- Mitosis-js (bundled in vendor/assets)

### Development (Demo App)
- Rails 8.1
- ActiveAdmin 4.0.0.beta21
- RSpec + RSpec-Rails
- Tailwind CSS with cssbundling-rails
- Propshaft for asset pipeline
