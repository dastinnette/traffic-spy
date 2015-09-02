require './test/test_helper'

class CreatingAClientTest<Minitest::Test
  include Rack::Test::Methods

  def app
    TrafficSpy::Server
  end

  def test_it_creates_a_client_with_valid_attributes
    attributes = {client: {identifier: "jumpstart lab",
                           rootUrl: "test stuff"}}
    post "/sources", attributes

    assert_equal 1, Client.count
    assert_equal 302, last_response.status
    assert_equal "{'identifier':'jumpstartlab'}", last_response
  end

end
