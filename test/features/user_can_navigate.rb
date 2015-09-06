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

  def test_the_source_page_exists
    visit("/sources")
    assert page.has_content?("Sources")
  end

  # def test_it_can_find_the_navbar
  #   visit("/")
  #   save_and_open_page
  #   assert page.has_css?("navbar")
  # end
end
