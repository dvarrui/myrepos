require "thor"
require_relative "version"
require_relative "../mygit"

module Mygit
  class CLI < Thor
    map ["-h", "--help"] => "help"

    map ["-i", "--init"] => "init"
    option :mode, type: :numeric
    desc "init --mode=NUMBER", "Initialize default repo files"
    long_desc <<-LONGDESC
    Create files for a new project.

    mode 1 => All folders

    mode 2 => Only README.md
    LONGDESC
    def init(dirpath = Dir.pwd)
      mode = options["mode"].to_i
      Mygit.init(File.absolute_path(dirpath), mode)
    end

    map ["-l", "--log"] => "log"
    desc "log", "Show log info from all repos"
    long_desc <<-LONGDESC
    Show log info from all repos
    LONGDESC
    def log
      Mygit.log
    end

    map ["--params"] => "params"
    desc "params", "Show params required by repo"
    long_desc <<-LONGDESC
    Show params required by repo
    LONGDESC
    def params
      Mygit.params
    end

    map ["-p", "--pull"] => "pull"
    desc "pull", "Pull all repos into current folder"
    long_desc <<-LONGDESC
    Pull all repos into current folder
    LONGDESC
    def pull
      Mygit.pull
    end

    map ["-r", "--rules"] => "rules"
    desc "rules", "Shows repositories that break the rules"
    long_desc <<-LONGDESC
    Shows repositories that break the rules
    LONGDESC
    def rules
      Mygit.rules
    end

    map ["-s", "--status"] => "status"
    desc "status", "Show local status"
    long_desc <<-LONGDESC
    Create files for a new project.
      Show local status
    LONGDESC
    def status(dirpath = Dir.pwd)
      Mygit.show_status(File.absolute_path(dirpath))
    end

    map ["-t", "--test"] => "test"
    desc "test", "Test server connection"
    long_desc <<-LONGDESC
    Create files for a new project.
      Test server connection
    LONGDESC
    def test
      Mygit.test
    end

    map ["-v", "--version"] => "version"
    desc "version", "Show version"
    long_desc <<-LONGDESC
    Create files for a new project.
      Show version
    LONGDESC
    def version
      Mygit.show_version
    end
  end
end
