require 'test_helper'

class ExcelDiffTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::ExcelDiff::VERSION
  end
end
