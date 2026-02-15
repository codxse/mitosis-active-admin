# activeadmin-mitosis-editor Design

**Date:** 2026-02-15

## Overview

A Ruby gem that wraps the `mitosis-js` npm package as a custom input type for ActiveAdmin, providing a split-view markdown editor with live preview.

## Architecture

### Components

1. **Input Class** - Formtastic-compatible input for ActiveAdmin DSL
2. **View Template** - ERB template that renders editor container + JS initialization
3. **Bundled Assets** - mitosis-js + Prism.js included in gem
4. **Railtie** - Registers assets with Rails asset pipeline

### Data Flow

1. **Form Load**: JS initializes editor with initial value (from model or empty)
2. **User Types**: Editor updates preview in real-time
3. **Form Submit**: JS copies markdown value to hidden input field for form submission

## DSL Usage

```ruby
# Basic usage
f.input :body, as: :mitosis_editor

# With options
f.input :body, as: :mitosis_editor, height: '400px', placeholder: 'Write markdown...'
```

## Supported Options

| Option | Type | Default | Description |
|--------|------|---------|-------------|
| `height` | string | `'500px'` | Editor container height |
| `placeholder` | string | `''` | Placeholder text |
| `prism_languages` | array | `['javascript', 'typescript', 'python', 'css']` | Syntax highlighting languages |

## File Structure

```
lib/
├── activeadmin_mitosis_editor.rb          # Main gem entry point
├── activeadmin_mitosis_editor/
│   ├── version.rb
│   └── railtie.rb                         # Rails integration
app/
├── inputs/
│   └── mitosis_editor_input.rb            # Formtastic input
├── views/
│   └── inputs/
│       └── mitosis_editor_input/
│           └── _form.html.erb             # Editor template
vendor/
└── assets/
    ├── javascripts/
    │   ├── mitosis-editor.js              # Bundled mitosis-js
    │   └── prism/                         # Bundled Prism.js
    └── stylesheets/
        └── mitosis-editor.css            # Bundled editor styles
```

## Implementation Notes

- Assets bundled from mitosis-js npm package (built dist)
- Self-hosted approach: assets served via gem's asset pipeline
- Works with Sprockets (Rails 6.x) and importmap (Rails 7.x)
