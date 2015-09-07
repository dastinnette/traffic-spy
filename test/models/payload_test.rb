require_relative '../test_helper'

class PayloadTest < Minitest::Test

  def test_it_assigns_proper_payload_elements
    payload_elements = {url: "test", hashed: "1aB3"}
    payload = Payload.new(payload_elements)
    assert_equal "test", payload.url
    assert_equal "1aB3", payload.hashed
  end

end
