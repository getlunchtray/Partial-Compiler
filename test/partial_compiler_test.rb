require 'test_helper'

class PartialCompilerTest < ActiveSupport::TestCase
  test "truth" do
    assert_kind_of Module, PartialCompiler
  end
end
