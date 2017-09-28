module ExcelDiff
  module UsingGit
    module_function

    def show(file, commit_id = "")
      commit_id = `git log -n 1 --format=%H`.chomp if commit_id.empty?

      commit_ids = `git log #{commit_id} -n 2 --format=%H`.split

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

      excel1 = ExcelDiff.excel_parse(files[1])
      excel2 = ExcelDiff.excel_parse(files[0])

      min_size = [excel1.sheets.size, excel2.sheets.size].min
      max_size = [excel1.sheets.size, excel2.sheets.size].max
      if excel2.sheets.size > excel1.sheets.size
        sheet_add = true
      end
      max_size.times do |nsheet|
        case nsheet
        when 0...min_size
          ExcelDiff.sheet_diff(excel1, excel2, nsheet)
        when min_size..max_size
          if sheet_add
            puts "sheet #{excel2.sheets[nsheet]} add"
          else
            puts "sheet #{excel1.sheets[nsheet]} delete"
          end
        end
      end

      files.each do |f|
        File.delete(f)
      end
    end
  end
end
