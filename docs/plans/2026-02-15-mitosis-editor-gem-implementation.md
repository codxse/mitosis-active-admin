# activeadmin-mitosis-editor Implementation Plan

> **For Claude:** REQUIRED SUB-SKILL: Use superpowers:executing-plans to implement this plan task-by-task.

**Goal:** Create a Ruby gem that wraps mitosis-js as a custom input type for ActiveAdmin, providing split-view markdown editing.

**Architecture:** Gem provides Formtastic input class + ERB view template + bundled JS/CSS assets. Users add to Gemfile and use `as: :mitosis_editor` in ActiveAdmin DSL.

**Tech Stack:** Ruby, Ruby Gems, ActiveAdmin, Formtastic, JavaScript (mitosis-js)

---

### Task 1: Initialize gem structure

**Files:**
- Create: `Gemfile`
- Create: `Rakefile`
- Create: `bin/setup`
- Create: `bin/console`
- Create: `Gemfile.lock`
- Create: `.gitignore`

**Step 1: Create basic gem structure**

```bash
mkdir -p lib/activeadmin_mitosis_editor
mkdir -p app/inputs
mkdir -p app/views/inputs/mitosis_editor_input
mkdir -p vendor/assets/javascripts
mkdir -p vendor/assets/stylesheets
mkdir -p spec
```

**Step 2: Create Gemfile**

```ruby
source "https://rubygems.org"

gemspec
```

**Step 3: Create gemspec**

```ruby
Gem::Specification.new do |spec|
  spec.name          = "activeadmin-mitosis-editor"
  spec.version       = "0.1.0"
  spec.authors       = ["Your Name"]
  spec.summary       = "A split-view markdown editor input for ActiveAdmin"
  spec.license      = "MIT"
  spec.files         = Dir["{app,lib,vendor}/**/*", "*.md"]
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "railties", ">= 6.0"
  spec.add_runtime_dependency "formtastic", "~> 4.0"
end
```

**Step 4: Commit**

```bash
git init
git add .
git commit -m "feat: scaffold gem structure"
```

---

### Task 2: Create main gem entry point

**Files:**
- Create: `lib/activeadmin_mitosis_editor.rb`
- Create: `lib/activeadmin_mitosis_editor/version.rb`

**Step 1: Create version.rb**

```ruby
module ActiveadminMitosisEditor
  VERSION = "0.1.0"
end
```

**Step 2: Create main entry point**

```ruby
require "activeadmin_mitosis_editor/version"

module ActiveadminMitosisEditor
  module Inputs
    autoload :MitosisEditorInput, "activeadmin_mitosis_editor/inputs/mitosis_editor_input"
  end
end
```

**Step 3: Commit**

```bash
git add lib/
git commit -m "feat: add gem entry point and version"
```

---

### Task 3: Create Formtastic input class

**Files:**
- Create: `lib/activeadmin_mitosis_editor/inputs/mitosis_editor_input.rb`

**Step 1: Create the input class**

```ruby
require "formtastic/inputs/string_input"

module ActiveadminMitosisEditor
  module Inputs
    class MitosisEditorInput < Formtastic::Inputs::StringInput
      def to_html
        input_wrapping do
          builder.hidden_field(method, input_html_options) +
          template.render("inputs/mitosis_editor_input/form", { builder: builder, method: method, input_html_options: input_html_options })
        end
      end

      def input_html_options
        super.merge(class: "mitosis-editor-input hidden", data: { mit_height: options[:height] || "500px", mit_placeholder: options[:placeholder] || "" })
      end
    end
  end
end
```

**Step 2: Commit**

```bash
git add lib/
git commit -m "feat: add Formtastic input class"
```

---

### Task 4: Create ERB view template

**Files:**
- Create: `app/views/inputs/mitosis_editor_input/_form.html.erb`

**Step 1: Create the template**

```erb
<div class="mitosis-editor-wrapper"
     data-input-name="<%= input_html_options[:name] %>"
     data-height="<%= input_html_options[:data][:mit_height] %>"
     data-placeholder="<%= input_html_options[:data][:mit_placeholder] %>">
  <div id="mitosis-editor-<%= input_html_options[:id] %>" class="mitosis-editor-container"></div>
</div>

<script>
(function() {
  var container = document.getElementById('mitosis-editor-<%= input_html_options[:id] %>');
  var wrapper = container.closest('.mitosis-editor-wrapper');
  var inputName = wrapper.dataset.inputName;
  var height = wrapper.dataset.height || '500px';
  var placeholder = wrapper.dataset.placeholder || '';

  // Find the hidden input
  var hiddenInput = document.querySelector('input[name="' + inputName + '"]');

  if (window.MitosisEditor) {
    var editor = window.MitosisEditor.createEditor({
      container: container,
      content: hiddenInput ? hiddenInput.value : '',
      height: height,
      placeholder: placeholder
    });

    // Sync editor content to hidden input on form submit
    var form = container.closest('form');
    if (form) {
      form.addEventListener('submit', function() {
        if (editor && editor.getMarkdown) {
          hiddenInput.value = editor.getMarkdown();
        }
      });
    }
  }
})();
</script>
```

**Step 2: Commit**

```bash
git add app/views/
git commit -m "feat: add ERB view template for editor"
```

---

### Task 5: Bundle mitosis-js assets

**Files:**
- Create: `vendor/assets/javascripts/mitosis-editor.js`
- Create: `vendor/assets/stylesheets/mitosis-editor.css`
- Create: `vendor/assets/javascripts/prism.js` (and language files)

**Step 1: Build mitosis-js**

```bash
cd /home/nadiar/Workspace/mitosis-js
pnpm install
pnpm build
```

**Step 2: Copy built assets**

```bash
cp /home/nadiar/Workspace/mitosis-js/dist/index.js vendor/assets/javascripts/mitosis-editor.js
cp /home/nadiar/Workspace/mitosis-js/dist/index.css vendor/assets/stylesheets/mitosis-editor.css 2>/dev/null || true
```

**Step 3: Download Prism.js**

```bash
curl -sL https://cdnjs.cloudflare.com/ajax/libs/prism/1.29.0/prism.min.js -o vendor/assets/javascripts/prism.js
curl -sL https://cdnjs.cloudflare.com/ajax/libs/prism/1.29.0/themes/prism-tomorrow.min.css -o vendor/assets/stylesheets/prism-tomorrow.css
```

**Step 4: Create editor initialization wrapper**

```javascript
// vendor/assets/javascripts/mitosis-editor.js
// Wrapper to expose mitosis-js as window.MitosisEditor

(function() {
  // mitosis-js will be loaded before this
  window.MitosisEditor = window.MitosisEditor || window.createEditor || {};
})();
```

**Step 5: Commit**

```bash
git add vendor/
git commit -m "feat: bundle mitosis-js and Prism.js assets"
```

---

### Task 6: Create Railtie for asset registration

**Files:**
- Create: `lib/activeadmin_mitosis_editor/railtie.rb`

**Step 1: Create Railtie**

```ruby
module ActiveadminMitosisEditor
  class Railtie < Rails::Railtie
    initializer "activeadmin_mitosis_editor.assets" do
      if defined?(Sprockets)
        Rails.application.config.assets.paths << Gem.root.join("vendor/assets/javascripts").to_s
        Rails.application.config.assets.paths << Gem.root.join("vendor/assets/stylesheets").to_s
      end
    end
  end
end
```

**Step 2: Update main entry to require railtie**

```ruby
# lib/activeadmin_mitosis_editor.rb
require "activeadmin_mitosis_editor/version"
require "activeadmin_mitosis_editor/railtie" if defined?(Rails)

module ActiveadminMitosisEditor
  # ...
end
```

**Step 3: Commit**

```bash
git add lib/
git commit -m "feat: add Railtie for asset pipeline integration"
```

---

### Task 7: Create gem spec file

**Files:**
- Create: `activeadmin_mitosis_editor.gemspec`

**Step 1: Create gemspec**

```ruby
Gem::Specification.new do |spec|
  spec.name          = "activeadmin_mitosis_editor"
  spec.version       = ActiveadminMitosisEditor::VERSION
  spec.authors       = ["Your Name"]
  spec.summary       = "A split-view markdown editor input for ActiveAdmin"
  spec.description   = "Wraps mitosis-js as a custom input for ActiveAdmin forms"
  spec.license       = "MIT"
  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(spec|\.git)}) }
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "railties", ">= 6.0"
  spec.add_runtime_dependency "formtastic", "~> 4.0"
  spec.add_runtime_dependency "activesupport", ">= 6.0"
end
```

**Step 2: Commit**

```bash
git add *.gemspec
git commit -m "feat: add gemspec file"
```

---

### Task 8: Create usage instructions

**Files:**
- Create: `README.md`

**Step 1: Create README**

```markdown
# ActiveadminMitosisEditor

A Ruby gem that provides a split-view markdown editor input for ActiveAdmin, powered by mitosis-js.

## Installation

Add this line to your Rails application's Gemfile:

```ruby
gem "activeadmin_mitosis_editor"
```

## Usage

In your ActiveAdmin resource:

```ruby
ActiveAdmin.register Article do
  form do |f|
    f.inputs do
      f.input :title
      f.input :body, as: :mitosis_editor
      f.input :body, as: :mitosis_editor, height: "400px", placeholder: "Write markdown..."
    end
    f.actions
  end
end
```

## Options

| Option | Type | Default | Description |
|--------|------|---------|-------------|
| height | string | '500px' | Editor height |
| placeholder | string | '' | Placeholder text |

## Requirements

- Rails >= 6.0
- ActiveAdmin
- Formtastic
```

**Step 2: Commit**

```bash
git add README.md
git commit -m "docs: add README with usage instructions"
```

---

## Summary

**Total Tasks:** 8

1. Initialize gem structure
2. Create main gem entry point
3. Create Formtastic input class
4. Create ERB view template
5. Bundle mitosis-js assets
6. Create Railtie for asset registration
7. Create gem spec file
8. Create usage instructions

---

## Execution Choice

**Plan complete and saved to `docs/plans/2026-02-15-mitosis-editor-gem-design.md` (implementation plan in this file).**

**Two execution options:**

1. **Subagent-Driven (this session)** - I dispatch fresh subagent per task, review between tasks, fast iteration

2. **Parallel Session (separate)** - Open new session with executing-plans, batch execution with checkpoints

Which approach?
