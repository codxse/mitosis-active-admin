# ActiveadminMitosisEditor

A Ruby gem that provides a split-view markdown editor input for ActiveAdmin, powered by mitosis-js.

## Installation

Add this line to your Rails application's Gemfile:

```ruby
gem "activeadmin_mitosis_editor"
```

Then run `bundle install`.

## Usage

In your ActiveAdmin resource:

```ruby
# Basic usage
ActiveAdmin.register Article do
  form do |f|
    f.inputs do
      f.input :title
      f.input :body, as: :mitosis_editor
    end
    f.actions
  end
end

# With custom options
ActiveAdmin.register Article do
  form do |f|
    f.inputs do
      f.input :title
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

## Development

After checking out the repo, run `bin/setup` to install dependencies.

## Contributing

Bug reports and pull requests are welcome on GitHub.

## License

The gem is available as open source under the terms of the MIT License.
