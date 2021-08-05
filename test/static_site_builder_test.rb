require "test_helper"

class StaticSiteBuilderTest < Minitest::Test
  def test_version
    refute_nil StaticSiteBuilder::VERSION
  end
end
