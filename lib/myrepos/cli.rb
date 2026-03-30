require "thor"
require_relative "../myrepos"

module MyRepos
  class CLI < Thor
    map ["-h", "--help"] => "help"

    map ["-i", "--init"] => "init"
    desc "init [DIRPATH]", "Create configuration files"
    long_desc <<-LONGDESC
    Create configuration files into 'DIRPATH/myrepos.d' folder:

    (1) config.yaml: main config file.
    
    (2) repos.yaml: contains repos data.
 
    LONGDESC
    def init(dirpath = Dir.pwd)
      MyRepos.init(dirpath)
    end

    map ["-r", "--refresh"] => "refresh"
    desc "refresh", "Refresh repos data"
    long_desc <<-LONGDESC
    Refresh repos data
    LONGDESC
    def refresh(dirpath = Dir.pwd)
      MyRepos.refresh(dirpath)
    end

    map ["-t", "--template"] => "template"
    desc "template [NAME]", "Add files from template NAME"
    long_desc <<-LONGDESC
    * template NAME, add files using the template NAME.

    * template, show template list

    LONGDESC
    def template(name=:list)
      MyRepos.template(name)
    end

    map ["-v", "--version"] => "version"
    desc "version", "Show version"
    long_desc <<-LONGDESC
    Create files for a new project.
      Show version
    LONGDESC
    def version
      MyRepos.show_version
    end
  end
end
