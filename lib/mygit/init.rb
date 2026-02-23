require "fileutils"
require "pastel"
require_relative "config"

class Init
  def initialize(dirpath)
    @config = Config.new(dirpath)
    @pastel = Pastel.new
  end

  def call
    configdir = @config.configdir
    create_dir(configdir)
    copy_files_into(configdir)
    puts @pastel.green("Configuration files created!")
  end

  private

  def create_dir(dirpath)
    return if Dir.exist? dirpath
    begin
      FileUtils.mkdir_p(dirpath)
    rescue
      puts @pastel.red.bold "ERROR | Creating folder!"
      puts @pastel.red "      | #{dirpath}"
      exit 1
    end
  end

  def copy_files_into(configdir)
    sourcedir = File.absolute_path(File.join(File.dirname(__FILE__), "files", "config"))
    dirpath = File.join(sourcedir)
    files = Dir.glob("#{dirpath}/*")
    files += Dir.glob("#{dirpath}/.?*")
    begin
      FileUtils.cp_r(files.sort, configdir)
    rescue
      puts @pastel.red.bold "ERROR | Creating config files!"
      files.each do |filename|
        puts @pastel.red "      | #{filename}"
      end
      exit 1
    end
  end
end
