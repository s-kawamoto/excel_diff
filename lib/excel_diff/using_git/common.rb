require 'fileutils'

module ExcelDiff
  module UsingGit
    module Common

      module_function

      def get_excel_commit_at(commit_id, file)
        if system("git log #{commit_id}:#{file} >/dev/null")
          tmp_dir = File.join(File.dirname(__FILE__), 'tmp')
          tmp_file_path = File.join(tmp_dir, commit_id + "_" + File.basename(file))

          FileUtils.mkdir_p(tmp_dir)
          system("git show #{commit_id}:#{file} > #{tmp_file_path}")
        else
          exit
        end
        tmp_file_path
      end
    end
  end
end
