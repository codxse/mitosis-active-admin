require "rails_helper"

RSpec.describe "Admin Articles", type: :system do
  before do
    driven_by :selenium, using: :headless_chrome, screen_size: [1400, 1400]
  end

  it "saves markdown body when creating an article" do
    visit "/admin/articles/new"

    fill_in "Title", with: "Test Article"

    editor_textarea = find(".mitosis-textarea", visible: :all)
    editor_textarea.set("# Hello World")

    click_button "Create Article"

    article = Article.last
    expect(article.title).to eq("Test Article")
    expect(article.body).to eq("# Hello World")
  end
end
