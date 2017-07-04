require 'excel_diff'
require 'fileutils'

module ExcelGitDiff

  module_function
  include ExcelDiff

  def excel_git_diff(file)
    commit_id = `git log -n 1 --format=%H`.chomp

    tmp_dir = File.join(File.dirname(__FILE__), 'tmp')
    diff_file_path = File.join(tmp_dir, File.basename(file))

    get_excel_commit_at(commit_id, file, diff_file_path)

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
        ExcelDiff.sheet_diff(excel1, excel2, nsheet)
      when min_size..max_size
        if sheet_add
          puts "sheet #{excel2.sheets[nsheet]} add"
        else
          puts "sheet #{excel1.sheets[nsheet]} delete"
        end
      end
    end

    File.delete(diff_file_path)
    Dir.rmdir(tmp_dir)
  end

  def get_excel_commit_at(commit_id, file, diff_file_path)
    if system("git log #{commit_id}:#{file} >/dev/null")
      FileUtils.mkdir_p( File.dirname(diff_file_path) )
      system("git show #{commit_id}:#{file} > #{diff_file_path}")
    else
      exit
    end
  end
end
