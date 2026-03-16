require "thor"
require_relative "../mygit"

module Mygit
  class CLI < Thor
    map ["-h", "--help"] => "help"

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

    map ["-r", "--refresh"] => "refresh"
    desc "refresh", "Refresh repos data"
    long_desc <<-LONGDESC
    Refresh repos data
    LONGDESC
    def refresh(dirpath = Dir.pwd)
      Mygit.refresh(dirpath)
    end

    map ["-t", "--template"] => "template"
    option :use
    desc "template [--use=NAME]", "Add files from template"
    long_desc <<-LONGDESC
    * --use=NAME, add files using the template NAME.

    * Or show available templates

    LONGDESC
    def template
      puts "template: #{options}"
      # Mygit.init(File.absolute_path(dirpath), mode)
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
