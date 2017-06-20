#encoding: utf-8

require "roo"
require "roo-xls"

module ExcelDiff
  module_function

  def excel_parse(file)
    case File.extname(file)
    when ".xlsx"
      Roo::Excelx.new(file)
    when ".xls"
      Roo::Excel.new(file)
    else
      raise "このファイルの拡張子は対応していません: #{file}"
    end
  end
end
