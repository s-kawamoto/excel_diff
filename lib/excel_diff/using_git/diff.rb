module ExcelDiff
  module UsingGit
    module_function

    def diff(file)
      status = true

      commit_id = `git log -n 1 --format=%H`.chomp

      diff_file_path = ExcelDiff::UsingGit::Common.get_excel_commit_at(commit_id, file)

      excel1 = ExcelDiff.excel_parse(diff_file_path)
      excel2 = ExcelDiff.excel_parse(file)

      status = ExcelDiff.all_sheet_diff(excel1, excel2)

      File.delete(diff_file_path)

      status
    end
  end
end
