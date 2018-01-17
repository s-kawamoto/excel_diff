module ExcelDiff
  module UsingGit
    module_function

    def diff(file)
      status = true

      commit_id = `git log -n 1 --format=%H`.chomp

      diff_file_path = ExcelDiff::UsingGit::Common.get_excel_commit_at(commit_id, file)

      excel1 = ExcelDiff.excel_parse(diff_file_path)
      excel2 = ExcelDiff.excel_parse(file)

      min_size = [excel1.sheets.size, excel2.sheets.size].min
      max_size = [excel1.sheets.size, excel2.sheets.size].max
      if excel2.sheets.size > excel1.sheets.size
        sheet_add = true
      end
      max_size.times do |nsheet|
        case nsheet
        when 0...min_size
          result = ExcelDiff.sheet_diff(excel1, excel2, nsheet)
          status &&= result
        when min_size..max_size
          status = false

          if sheet_add
            puts "sheet #{excel2.sheets[nsheet]} add"
          else
            puts "sheet #{excel1.sheets[nsheet]} delete"
          end
        end
      end

      File.delete(diff_file_path)

      status
    end
  end
end
