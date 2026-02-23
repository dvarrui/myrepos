require "fileutils"
require "pastel"

class Init
  attr_reader :configdir

  def initialize(dirpath)
    abs_path = File.absolute_path(dirpath)
    @configdir = File.join(abs_path, "mygit.d")
    @pastel = Pastel.new
  end

  def call
    sourcedir = File.absolute_path(File.join(File.dirname(__FILE__), "files", "config"))
    puts sourcedir
    puts @configdir

    puts "\nCreating configuration files"
    create_dir(@configdir)

    dirpath = File.join(sourcedir, dirname)
    files = Dir.glob("#{dirpath}/*")
    files += Dir.glob("#{dirpath}/.?*")
    FileUtils.cp_r(files.sort, targetdir)
  end

  private

  def create_dir(dirpath)
    if Dir.exist? dirpath
      puts "* Exists dir!       => #{pastel.yellow(dirpath)}"
    else
      begin
        FileUtils.mkdir_p(dirpath)
        puts "* Create dir        => #{pastel.green(dirpath)}"
      rescue
        puts "* Create dir  ERROR => #{pastel.red(dirpath)}"
      end
    end
  end

  def create_main_dir_and_files(project_dir, source_basedir)
    # Directory and files: Ruby script, Configfile, gitignore
    items = [
      {source: "files/config.yaml", target: "config.yaml"},
      {source: "files/start.rb", target: "start.rb"}
    ]
    items.each do |item|
      source = File.join(source_basedir, item[:source])
      target = File.join(project_dir, item[:target])
      copyfile(source, target)
    end
  end

  def copyfile(source, dest)
    if File.exist? dest
      puts "* Exists file!      => #{Rainbow(dest).yellow}"
    else
      puts "* File not found!   => #{Rainbow(source).yellow}" unless File.exist? source
      begin
        FileUtils.cp(source, dest)
        puts "* Create file       => #{Rainbow(dest).green}"
      rescue
        puts "* Create file ERROR => #{Rainbow(dest).red}"
      end
    end
  end
end
