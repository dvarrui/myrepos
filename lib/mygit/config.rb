require "fileutils"
require "pastel"

class Config
  attr_reader :dirpath
  attr_reader :abs_dirpath
  attr_reader :configdir
  
  def initialize(dirpath)
    @dirpath =dirpath 
    @abs_dirpath = File.absolute_path(@dirpath)
    @configdir = File.join(@abs_dirpath, "mygit.d")
    @pastel = Pastel.new
    # configfiles = Dir.
  end
  
  def exist?
    puts "config:"
  end

  def create
    configdir = @configdir
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
  