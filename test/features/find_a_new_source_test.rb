require_relative '../test_helper'

class FindNewSourceTest < FeatureTest
  include Rack::Test::Methods
  include TrafficSpy

  def setup
    @data1 = 'payload={"url":"http://jumpstartlab.com/blog","requestedAt":"2013-02-16 21:38:28 -0700","respondedIn":37,"referredBy":"http://jumpstartlab.com","requestType":"GET","parameters":[],"eventName": "socialLogin","userAgent":"Mozilla/5.0 (Macintosh%3B Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17","resolutionWidth":"1920","resolutionHeight":"1280","ip":"63.29.38.211"}'
    @data2 = 'payload={"url":"http://jumpstartlab.com/blog","requestedAt":"2013-02-16 21:38:28 -0700","respondedIn":37,"referredBy":"http://jumpstartlab.com","requestType":"GET","parameters":[],"eventName": "socialLogin","userAgent":"Mozilla/5.0 (Macintosh%3B Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17","resolutionWidth":"1920","resolutionHeight":"1280","ip":"63.29.8.211"}'
    @data3 = 'payload={"url":"http://jumpstartlab.com/article/1","requestedAt":"2013-02-16 21:38:28 -0700","respondedIn":37,"referredBy":"http://jumpstartlab.com","requestType":"GET","parameters":[],"eventName": "socialLogin","userAgent":"Mozilla/5.0 (Macintosh%3B Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17","resolutionWidth":"1920","resolutionHeight":"1280","ip":"63.29.38.211"}'
    @data4 = 'payload={"url":"http://jumpstartlab.com/article/1","requestedAt":"2013-02-16 21:38:28 -0700","respondedIn":37,"referredBy":"http://jumpstartlab.com","requestType":"GET","parameters":[],"eventName": "socialLogin","userAgent":"Mozilla/5.0 (Macintosh%3B Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17","resolutionWidth":"1920","resolutionHeight":"80","ip":"63.29.38.211"}'
  end

  def test_it_can_find_the_navbar
    visit("/")
    within("#capy") do
      click_link("Sources")
    end
    assert current_path == "/sources"
    assert page.has_content?("Sources")
  end

  def test_it_can_create_and_click_source
    post "/sources", client
    visit "/sources"

    assert_equal 1, Source.count
    assert page.has_link?("Jumpstartlab")
  end

  def test_it_redirects_to_new_page_with_no_payload
    post "/sources", client
    visit "/sources"
    click_link("Jumpstartlab")

    assert page.has_content?("jumpstartlab")
  end

  def test_it_redirects_to_new_page_with_payload_data
    post "/sources", client
    post "/sources/jumpstartlab/data", @data1
    visit "/sources"
    click_link("Jumpstartlab")

    assert page.has_content?("Chrome")
    assert page.has_content?("Macintosh")
    assert page.has_content?("jumpstartlab")
    assert page.has_content?("http://jumpstartlab.com/blog : Was requested 1 time(s)")
  end

  def test_it_redirects_to_new_page_with_multiple_payloads
    post "/sources", client
    post "/sources/jumpstartlab/data", @data1
    post "/sources/jumpstartlab/data", @data2
    post "/sources/jumpstartlab/data", @data3
    post "/sources/jumpstartlab/data", @data4
    visit "/sources"
    click_link("Jumpstartlab")

    assert page.has_content?("Chrome")
    assert page.has_content?("Macintosh")
    assert page.has_content?("jumpstartlab")
    assert page.has_content?("http://jumpstartlab.com/blog : Was requested 2 time(s)")
    assert page.has_content?("http://jumpstartlab.com/article/1 : Was requested 2 time(s)")
    assert page.has_content?("1280 x 1920")
    assert page.has_content?("80 x 1920")
  end
end
