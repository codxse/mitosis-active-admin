require "rails_helper"

RSpec.describe "Mitosis Editor Theme", type: :system do
  before do
    driven_by :selenium, using: :headless_chrome, screen_size: [1400, 1400]
  end

  after do
    execute_script("localStorage.clear(); document.documentElement.classList.remove('dark')")
  end

  def editor_wrapper
    find(".mitosis-editor-wrapper[data-theme]", visible: :all)
  end

  def toggle_aa_dark_mode
    execute_script("localStorage.setItem('theme', 'dark'); document.documentElement.classList.add('dark')")
  end

  def toggle_aa_light_mode
    execute_script("localStorage.setItem('theme', 'light'); document.documentElement.classList.remove('dark')")
  end

  context "with theme: 'dark' (Article)" do
    it "always uses dark theme regardless of AA theme" do
      visit "/admin/articles/new"

      expect(editor_wrapper["data-theme"]).to eq("dark")

      toggle_aa_dark_mode
      expect(editor_wrapper["data-theme"]).to eq("dark")

      toggle_aa_light_mode
      expect(editor_wrapper["data-theme"]).to eq("dark")
    end
  end

  context "with theme: 'light' (Post)" do
    it "always uses light theme regardless of AA theme" do
      visit "/admin/posts/new"

      expect(editor_wrapper["data-theme"]).to eq("light")

      toggle_aa_dark_mode
      expect(editor_wrapper["data-theme"]).to eq("light")
    end
  end

  context "with theme: 'auto' (Page)" do
    it "follows AA theme changes" do
      visit "/admin/pages/new"

      toggle_aa_light_mode
      expect(editor_wrapper["data-theme"]).to eq("light")

      toggle_aa_dark_mode
      expect(editor_wrapper["data-theme"]).to eq("dark")

      toggle_aa_light_mode
      expect(editor_wrapper["data-theme"]).to eq("light")
    end
  end
end
