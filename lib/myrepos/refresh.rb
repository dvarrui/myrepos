require_relative "config"

module MyRepos
  class Refresh
    def initialize(dirpath)
      @config = MyRepos::Config.new(dirpath)
      @config.load
      @pastel = Pastel.new
    end

    def call
      puts "==> [myrepos] Refreshing local repos..."
      find_local_repos
    end

    def find_local_repos
      local_repo_paths = []
      @config.data[:local_repos].each do |basedir|
        puts "==> [myrepos] Looking into: #{@pastel.green(basedir)}"
        filepaths = Dir.glob(File.join(basedir, "*/**/.git"))
        local_repo_paths += filepaths.map { File.dirname(_1) }
      end
      puts local_repo_paths.join("\n")
    end
  end
end
