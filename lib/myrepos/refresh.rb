require_relative "config"

class Refresh
  def initialize(dirpath)
    @config = Config.new(dirpath)
    @pastel = Pastel.new
  end

  def call
    puts "==> [myrepos] Refreshing..."
    @config.load
    puts @config.data
    find_local_repos
  end

  def find_local_repos
    local_repo_paths = []
    @config.data[:local_repos].each do |basedir|
      filepaths = Dir.glob(File.join(basedir, "*/**/.git"))
      local_repo_paths += filepaths.map { File.dirname(_1) }
    end
    puts local_repo_paths.join("\n")
  end
end
