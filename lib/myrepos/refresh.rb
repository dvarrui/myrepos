require_relative "config"
require_relative "repo/local"

module MyRepos
  class Refresh
    def initialize(dirpath)
      @config = MyRepos::Config.new(dirpath)
      @config.load
      @pastel = Pastel.new
      @local_repos = get_local_repos
    end

    def call
      puts "==> [refresh] local repos..."
      @local_repos.each do
        puts @pastel.yellow.bold("==> [refresh] pull #{it.basedir}...")
        it.pull
      end
    end

    def show
      puts "==> [refresh] List:"
      @local_repos.each do
        puts "    " + @pastel.blue.bold(it.to_s)
      end
    end

    private

    def get_local_repos
      local_repos = []
      @config.data[:local_repos].each do |basedir|
        local_repos += LocalRepo.get_local_repos(basedir)
      end
      local_repos
    end
  end
end
