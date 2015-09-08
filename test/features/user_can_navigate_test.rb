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

  def test_it_can_find_the_navbar
    visit("/")
    assert page.has_css?("html", "#capy")
  end

  def test_it_can_go_home_from_sources
    visit("/sources")
    click_link("Home")

    assert page.has_content?("Hello, Traffic Spyer")
  end

  def test_it_can_go_to_traffic_spy_home_from_sources
    visit("/sources")
    click_link("Traffic Spy")

    assert page.has_content?("Hello, Traffic Spyer")
  end
end
