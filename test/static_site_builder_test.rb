require "test_helper"

class StaticSiteBuilderTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil StaticSiteBuilder::VERSION
  end
end
