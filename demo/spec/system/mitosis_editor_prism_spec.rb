require "rails_helper"

RSpec.describe "Mitosis Editor Prism Syntax Highlighting", type: :system do
  before do
    driven_by :selenium, using: :headless_chrome, screen_size: [ 1400, 1400 ]
  end

  it "loads Prism CSS and JS when enabled" do
    visit "/admin/articles/new"

    html = page.html

    # Check Prism CSS is loaded
    expect(html).to include("prismjs@1.29.0/themes/prism-tomorrow.min.css")

    # Check Prism JS scripts are loaded
    expect(html).to include("prismjs@1.29.0/prism.min.js")
    expect(html).to include("prism-javascript.min.js")
    expect(html).to include("prism-typescript.min.js")
    expect(html).to include("prism-python.min.js")
    expect(html).to include("prism-css.min.js")
  end

  it "makes Prism available globally" do
    visit "/admin/articles/new"

    # Wait for page to fully load
    expect(page).to have_css(".mitosis-editor-wrapper")

    # Verify Prism is available on window
    prism_available = page.evaluate_script("typeof window.Prism !== 'undefined'")
    expect(prism_available).to be true
  end
end
