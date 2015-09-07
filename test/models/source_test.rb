require_relative '../test_helper'

class SourceTest < Minitest::Test

  def test_it_assigns_proper_attributes
    attributes = {identifier: "jumpstartlab", root_url: "http://jumpstartlab.com"}
    source = Source.new(attributes)
    assert_equal "jumpstartlab", source.identifier
    assert_equal "http://jumpstartlab.com", source.root_url
  end

end
