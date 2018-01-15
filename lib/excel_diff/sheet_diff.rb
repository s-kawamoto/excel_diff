#encoding: utf-8

require "diffy"

module ExcelDiff
  module_function

  def sheet_diff(excel1, excel2, nsheet, n2: nil, using: 'linux')

    if nsheet
      excel1.default_sheet = excel1.sheets[nsheet.to_i]
      nsheet2 = (n2 || nsheet)
      excel2.default_sheet = excel2.sheets[nsheet2.to_i]
    end

    csv1 = excel1.to_csv
    csv2 = excel2.to_csv

    case using
    when 'linux'
      require 'fileutils'

      tmp_dir = File.join(File.dirname(__FILE__), 'tmp')
      FileUtils.mkdir_p(tmp_dir)

      tmp1 = File.join(tmp_dir, "tmp1sheet#{nsheet}.csv")
      File.open(tmp1, 'w') do |f|
        f.print csv1
      end

      tmp2 = File.join(tmp_dir, "tmp2sheet#{nsheet2}.csv")
      File.open(tmp2, 'w') do |f|
        f.puts csv2
      end

      status = system("diff -u #{tmp1} #{tmp2}")
      File.delete(tmp1, tmp2)
      Dir.rmdir(tmp_dir)

    when 'diffy'
      #puts Diffy::Diff.new(csv1, csv2).to_s
      puts Diffy::Diff.new(csv1, csv2, :include_diff_info => true).to_s
    else
      raise 'diffを選択してください。'
    end

    status
  end
end
