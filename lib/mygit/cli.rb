require "thor"
require_relative "../mygit"

module Mygit
  class CLI < Thor
    map ["-h", "--help"] => "help"

    map ["-r", "--repos"] => "repos"
    desc "repos", "Manage repos data"
    long_desc <<-LONGDESC
    Manage repos data
    LONGDESC
    def repos
      puts "repos: #{options}"
    end

    map ["-t", "--template"] => "template"
    option :use
    option :list, type: :boolean
    desc "template [--use=NAME|--list", "create files in the repository using the template"
    long_desc <<-LONGDESC
    * --use=NAME, create files in the repository using the template.

    * --list, Show available templates
    LONGDESC
    def template
      puts "template: #{options}"
      #Mygit.init(File.absolute_path(dirpath), mode)
    end

    map ["-i", "--init"] => "init"
    desc "init [DIRPATH]", "Create configuration files"
    long_desc <<-LONGDESC
    Create configuration files into 'DIRPATH/mygit.d' folder:

    (1) config.yaml: main config file.
    
    (2) repos.yaml: contains repos data.
 
    LONGDESC
    def init(dirpath = Dir.pwd)
      Mygit.init(dirpath)
    end

    map ["-s", "--server"] => "server"
    desc "server", "Manage server"
    long_desc <<-LONGDESC
    Manage server
    LONGDESC
    def server
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
