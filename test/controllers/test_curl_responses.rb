require '../test_helper'

class CurlResponseTest<Minitest::Test
  include Rack::Test::Methods

  def app
    TrafficSpy::Server
  end

  def test_it_creates_a_client_with_valid_attributes
    attributes = {client: {identifier: "jumpstart lab",
                           rootUrl: "test stuff"}}
    post "/tasks", attributes

    assert_equal 1, Task.count
    assert_equal 200, last_response.status
    assert_equal "{'identifier':'jumpstartlab'}", last_response.body
  end

end
