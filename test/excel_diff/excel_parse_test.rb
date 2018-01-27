require 'test_helper'

=begin
# テストしたいもの
1. xlsxをparseするとRoo::Excelxクラスのインスタンスが生成されること
2. xlsをparseするとRoo::Excelクラスのインスタンスが生成されること
3. 予期せぬ拡張子のファイルをparseしようとするとRuntimeErrorが発生すること FIXME: エラーではなくnilが返るように昨日変更を行う
4. ファイルが無かった場合にIOErrorが発生すること TODO: これもnilを返す方が良いかどうか？
5. TODO: 中身はExcelファイルではないが拡張子がxlsxのファイルをparseした時
6. TODO: 中身はExcelファイルではないが拡張子がxlsのファイルをparseした時
7. TODO: 拡張子がないが、ファイル名が「〜〜〜xlsx」のファイルをparseした時
8. TODO: 拡張子がないが、ファイル名が「〜〜〜xls」のファイルをparseした時
=end

class ExcelParseTest < Minitest::Test
  def test_that_it_parses_file_with_extension_xlsx_correctly
    assert_instance_of Roo::Excelx, ExcelDiff.excel_parse("#{SAMPLEDIR}/test1.xlsx")
  end

  def test_that_it_parses_file_with_extension_xls_correctly
    assert_instance_of Roo::Excel, ExcelDiff.excel_parse("#{SAMPLEDIR}/sample.xls")
  end

  def test_that_RuntimeError_occurs_when_parsing_unexpected_extension
    assert_raises RuntimeError do
      ExcelDiff.excel_parse("#{SAMPLEDIR}/../README.md")
    end
  end

  def test_that_IOError_occurs_when_parsing_file_that_does_not_exist
    assert_raises IOError do
      ExcelDiff.excel_parse("#{SAMPLEDIR}/not_exist_file.xlsx")
    end
  end
end
