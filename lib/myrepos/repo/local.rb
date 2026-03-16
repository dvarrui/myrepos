require "pastel"
require_relative "branch"

module MyRepos
  class LocalRepo
    attr_reader :basedir
    attr_reader :branch

    def initialize(basedir)
      @pastel = Pastel.new
      @basedir = basedir
      @pull_state = false
      @branch = Branch.new(@basedir)
    end

    def to_s
      options = []
      options << "pull=#{@pull_state}]" unless @pull_state
      options << "current_branch=#{@branch.current}"
      options << "branches=#{@branch.all.join(",")}"
      "LocalRepo: #{@basedir} |#{options.join('|')}"
    end

    def pull
      Dir.chdir(@basedir) do
        begin
          @pull_state = system("git pull")
        rescue => e
          puts @pastel.red.bold("==> [LocalRepo.pull] Error: #{e.message}")
          @pull_state = false
        end
      end
      @pull_state
    end

    def load_info
      # name
      # ==> remote_repo: desc, members
      @branch.load
      # remote_branches
      # last_branch
      # files (ficheros agrupados por tipo)
      # main_type
      # empty
      # submodules
      # last_user
      # last_email
      # last_date
    end

    def self.get_local_repos(basedir)
      filepaths = Dir.glob(File.join(basedir, "*/**/.git"))
      local_paths = filepaths.map { File.dirname(_1) }
      local_paths.map { |path| LocalRepo.new(path)}
    end
  end
end