require "fileutils"
require "pastel"

class Config
  attr_reader :dirpath
  attr_reader :abs_dirpath
  attr_reader :configdir

  def initialize(dirpath)
    @dirpath = dirpath
    @abs_dirpath = File.absolute_path(@dirpath)
    @configdir = File.join(@abs_dirpath, "mygit.d")
    @pastel = Pastel.new
    # configfiles = Dir.
  end

  def exist?
    template = all_template_files
    real = all_real_files
    (template - real).empty?
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
    true
  end

  private

  def all_template_filepaths
    sourcedir = File.absolute_path(File.join(File.dirname(__FILE__), "files", "config"))
    dirpath = File.join(sourcedir)
    files = Dir.glob("#{dirpath}/*")
    files += Dir.glob("#{dirpath}/.?*")
    files
  end

  def all_template_files
    files = all_template_filepaths
    files.map { File.basename(_1) }
  end

  def all_real_files
    dirpath = @configdir
    files = Dir.glob("#{dirpath}/*")
    files += Dir.glob("#{dirpath}/.?*")
    files.map { File.basename(_1) }
  end

  def create_dir(dirpath)
    FileUtils.mkdir_p(dirpath)
  rescue
    puts @pastel.red.bold "ERROR | Creating folder!"
    puts @pastel.red "      | #{dirpath}"
    exit 1
  end

  def copy_files_into(configdir)
    files = all_template_filepaths
    begin
      FileUtils.cp_r(files.sort, configdir)
    rescue
      puts @pastel.red.bold "ERROR | Creating config files!"
      files = all_template_filepaths
      files.each do |filename|
        puts @pastel.red "      | #{filename}"
      end
      exit 1
    end
  end
end
