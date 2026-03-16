require_relative "config"
require_relative "repo/local"

module MyRepos
  class Refresh
    def initialize(dirpath)
      @config = MyRepos::Config.new(dirpath)
      @config.load
      @pastel = Pastel.new
      @local_repos = []
    end

    def call
      puts "==> [myrepos] Refreshing local repos..."
      find_local_repos
    end

    def show
      @local_repos.each do 
        puts it.show
      end
    end

    private

    def find_local_repos
      local_repo_paths = []
      @config.data[:local_repos].each do |basedir|
        puts "==> [myrepos] Searching within: #{@pastel.green(basedir)}"
        filepaths = Dir.glob(File.join(basedir, "*/**/.git"))
        local_repo_paths += filepaths.map { File.dirname(_1) }
      end
      local_repo_paths.each do |localrepopath|
        @local_repos << LocalRepo.new(localrepopath)
      end
    end
  end
end
