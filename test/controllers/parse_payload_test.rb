require './test/test_helper'

class ParsePayloadTest<Minitest::Test
  include Rack::Test::Methods
  include TrafficSpy

  def setup
    post "/sources", client
    @data = 'payload={"url":"http://jumpstartlab.com/blog","requestedAt":"2013-02-16 21:38:28 -0700","respondedIn":37,"referredBy":"http://jumpstartlab.com","requestType":"GET","parameters":[],"eventName": "socialLogin","userAgent":"Mozilla/5.0 (Macintosh%3B Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17","resolutionWidth":"1920","resolutionHeight":"1280","ip":"63.29.38.211"}'
  end

  def test_it_can_parse_payload
    post "/sources/jumpstartlab/data", @data

    assert_equal 1, Payload.count
    assert_equal 200, last_response.status
  end

  def test_empty_payload_returns_bad_request
    post "/sources/jumpstartlab/data", "payload={}"

    assert_equal 0, Payload.count
    assert_equal 400, last_response.status
  end

  def test_missing_payload_returns_bad_request
    post "/sources/jumpstartlab/data"

    assert_equal 0, Payload.count
    assert_equal 400, last_response.status
  end

  def test_already_received_payload_returns_error
    post "/sources/jumpstartlab/data", @data
    post "/sources/jumpstartlab/data", @data

    assert_equal 1, Payload.count
    assert_equal 403, last_response.status
  end

end
