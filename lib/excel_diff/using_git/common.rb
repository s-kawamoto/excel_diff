require 'fileutils'

module ExcelDiff
  module UsingGit
    module Common

      module_function

      def get_excel_commit_at(commit_id, file)
        exit unless in_repository?
        file_path_from_toplevel = path_from_toplevel(file)

        if system("git log #{commit_id}:#{file_path_from_toplevel} >/dev/null")
          tmp_dir = File.join(File.dirname(__FILE__), 'tmp')
          tmp_file_path = File.join(tmp_dir, commit_id + "_" + File.basename(file))

          FileUtils.mkdir_p(tmp_dir)
          system("git show #{commit_id}:#{file_path_from_toplevel} > #{tmp_file_path}")
        else
          exit
        end
        tmp_file_path
      end

      def path_from_toplevel(file)
        require 'pathname'

        toplevel_path = Pathname.new(`git rev-parse --show-toplevel`.chomp)
        absolute_file_path = Pathname.new(File.absolute_path(file))
        file_path_from_toplevel = absolute_file_path.relative_path_from(toplevel_path)
        file_path_from_toplevel.to_s
      end

      def in_repository?
        system('git rev-parse --show-toplevel >/dev/null')
      end
    end
  end
end
