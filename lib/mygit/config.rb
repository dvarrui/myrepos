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
  
  def create
    if exist?
      puts @pastel.yellow.bold("Configuration files OK!")
      return true
    end
    configdir = @configdir
    create_dir(configdir)
    copy_files_into(configdir)
    puts @pastel.green("Configuration files created!")
  end
  
  private
  
  def all_template_config_files
    sourcedir = File.absolute_path(File.join(File.dirname(__FILE__), "files", "config"))
    dirpath = File.join(sourcedir)
    files = Dir.glob("#{dirpath}/*")
    files += Dir.glob("#{dirpath}/.?*")
    files
  end

  def all_real_config_files
    dirpath = @configdir
    files = Dir.glob("#{dirpath}/*")
    files += Dir.glob("#{dirpath}/.?*")
    files
  end

  def exist?
    files = all_real_config_files
    return false if files.empty?
    files.all? { |filename| File.exist?(filename) }
  end

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
    files = all_real_config_files
    begin
      FileUtils.cp_r(files.sort, configdir)
    rescue
      puts @pastel.red.bold "ERROR | Creating config files!"
      files = all_template_config_files
      files.each do |filename|
        puts @pastel.red "      | #{filename}"
      end
      exit 1
    end
  end  
end
  