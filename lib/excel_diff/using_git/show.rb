module ExcelDiff
  module UsingGit
    module_function

    def show(file, commit_id = "")
      commit_id = `git log -n 1 --format=%H`.chomp if commit_id.empty?

      commit_ids = `git log #{commit_id} -n 2 --format=%H`.split.reverse!

      if commit_ids.size == 1
        puts "first commit"
        exit
      elsif commit_ids.size < 0
        puts "error"
        exit
      end

      files = []
      commit_ids.each do |id|
        files << ExcelDiff::UsingGit::Common.get_excel_commit_at(id, file)
      end

      system("git log #{commit_id} -n 1")

      excel1 = ExcelDiff.excel_parse(files[0])
      excel2 = ExcelDiff.excel_parse(files[1])

      status = ExcelDiff.all_sheet_diff(excel1, excel2)

      files.each do |f|
        File.delete(f)
      end

      status
    end
  end
end
