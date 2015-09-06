require_relative '../test_helper'

class UserCanNavigateTest < FeatureTest
  def test_home_page_displays_welcome_message
    visit("/")
    assert page.has_content?("Hello, Traffic Spyer")
  end

  def test_home_page_displays_welcome_message
    visit("/")
    assert page.has_css?("html", "jumbotron")
  end
end
