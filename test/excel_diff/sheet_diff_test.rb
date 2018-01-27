require 'test_helper'

=begin
# テストしたいもの
1-1. xlsxとxlsxが差がない時true
1-2. xlsxとxlsxが差がある時false
1-3. xlsxとxlsxでページが追加された場合false

2-1. xlsxとxlsが差がない時true
2-2. xlsxとxlsが差がある時false
2-3. xlsxとxlsでページが追加された場合false
=end

class SheetDiffTest < Minitest::Test
=begin
  def setup
    @excel1 = ExcelDiff.excel_parse("#{SAMPLEDIR}/test1.xlsx")
    @excel2 = ExcelDiff.excel_parse("#{SAMPLEDIR}/test1.xlsx")
  end

  def test_return_true
    assert_equal true, ExcelDiff.sheet_diff(@excel1, @excel2)
  end

  def test_return_false
    assert_equal true, ExcelDiff.sheet_diff(@excel1, @excel2)
  end
=end
end
