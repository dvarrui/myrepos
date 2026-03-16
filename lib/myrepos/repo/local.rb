require "pastel"

module MyRepos
  class LocalRepo
    attr_reader :basedir

    def initialize(basedir)
      @pastel = Pastel.new
      @basedir = basedir
      @pull_state = false
    end

    def to_s
      "LocalRepo: #{@basedir} [pull=#{@pull_state}]"
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

    def self.get_local_repos(basedir)
      filepaths = Dir.glob(File.join(basedir, "*/**/.git"))
      local_paths = filepaths.map { File.dirname(_1) }
      local_paths.map { |path| LocalRepo.new(path)}
    end
  end
end