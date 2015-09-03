require './test/test_helper'

class CreatingAClientTest<Minitest::Test
  include Rack::Test::Methods
  include TrafficSpy

  def app
    TrafficSpy::Server
  end

  def setup
    DatabaseCleaner.start
  end

  def teardown
    DatabaseCleaner.clean
  end

  def test_it_creates_a_client_with_valid_attributes
    attributes = {identifier: "jumpstart lab",
                  rootUrl: "test stuff"}
    post "/sources", attributes

    assert_equal 1, Client.count
    assert_equal 200, last_response.status
    assert_equal "{\"identifier\":\"jumpstart lab\"}", last_response.body
  end

  def test_it_does_not_create_a_client_when_identifier_already_taken
    attributes = {identifier: "jumpstart lab",
                  rootUrl: "test stuff"}
    attributes2 = {identifier: "jumpstart lab",
                  rootUrl: "test stuff"}
    post "/sources", attributes
    post "/sources", attributes2

    assert_equal 1, Client.count
    assert_equal 403, last_response.status
  end

  def test_it_does_not_create_a_client_with_invalid_attributes
    attributes = {identifier: "jumpstart lab"}
    post "/sources", attributes

    assert_equal 0, Client.count
    assert_equal 400, last_response.status
  end

end
